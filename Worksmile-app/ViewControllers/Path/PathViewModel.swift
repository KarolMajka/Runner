//  
//  PathViewModel.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import RxSwift

final class PathViewModel: ViewModel {

    var input = Input()
    var output = Output()

    private var shouldShowInvalidPoints = true

    private var allPoints: [Point] = []
    private var allValidPoints: [Point] = []

    private var mapCellViewModel: PathMapCellViewModel?
    private var cellViewModels: [CellViewModel] = []

    struct Dependencies {
        let pointsService: PointsServiceProtocol
        let anomalyInteractor: PathAnomalyInteractorProtocol
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
        prepareViewModel()
    }
}

// MARK: - Preparation
private extension PathViewModel {
    func prepareViewModel() {
        setupRxObservers()

        fetchPoints()
    }

    func fetchPoints() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                var points = try self?.dependencies.pointsService.fetchPoints().compactMap { $0.point } ?? []
                self?.dependencies.anomalyInteractor.markAnomalyPoints(points: &points)

                DispatchQueue.main.async { [weak self] in
                    self?.allPoints = points
                    self?.allValidPoints = points.filter { $0.isAnomaly == false }

                    self?.preparePoints(points: points)
                }
            } catch {
                print("Error during points fetching \(error.localizedDescription).")
            }
        }
    }

    func preparePoints(points: [Point]) {
        let mapCell = PathMapCellViewModel(dependencies: .init(points: points))
        if let mapCellViewModel = mapCellViewModel {
            mapCell.applyPreviousConfiguration(previousCell: mapCellViewModel)
        }
        let cellViewModels = points.map { PathPointCellViewModel(dependencies: .init(point: $0)) }

        self.mapCellViewModel = mapCell
        self.cellViewModels = cellViewModels

        output.view.reloadData.onNext(())
    }

    func refreshMap() {
        let points = shouldShowInvalidPoints ? allPoints : allValidPoints

        let mapCell = PathMapCellViewModel(dependencies: .init(points: points))
        if let mapCellViewModel = mapCellViewModel {
            mapCell.applyPreviousConfiguration(previousCell: mapCellViewModel)
        }

        self.mapCellViewModel = mapCell
        output.view.reloadData.onNext(())
    }
}

// MARK: - RxObservers
private extension PathViewModel {
    func setupRxObservers() {
        setupInputActionObserver()
    }

    func setupInputActionObserver() {
        input.view.didAction
            .subscribe(onNext: { [weak self] action in
                guard let strongSelf = self else { return }
                switch action {
                case .filterPressed:
                    strongSelf.filterPressed()
                case .itemPressed(let indexPath):
                    strongSelf.itemPressed(indexPath: indexPath)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension PathViewModel {
    func filterPressed() {
        shouldShowInvalidPoints.toggle()
        refreshMap()
    }

    func itemPressed(indexPath: IndexPath) { }
}

// MARK: - CellsDataSource
extension PathViewModel: CellsDataSource {
    func numberOfSections() -> Int {
        return mapCellViewModel == nil ? 0 : 2
    }

    func numberOfItems(inSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return cellViewModels.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModel {
        if indexPath.section == 0 {
            return mapCellViewModel!
        }
        return cellViewModels[indexPath.row]
    }
}

// MARK: - Input
extension PathViewModel {
    struct Input {
        var view = View()

        struct View {
            enum Action {
                case filterPressed
                case itemPressed(IndexPath)
            }
            let didAction = PublishSubject<Action>()
        }
    }
}

// MARK: - Output
extension PathViewModel {
    struct Output {
        var view = View()

        struct View {
            let reloadData = PublishSubject<Void>()
        }
    }
}
