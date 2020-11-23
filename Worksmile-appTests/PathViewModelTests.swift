//
//  PathViewModelTests.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 22/11/2020.
//

import XCTest
import RxSwift
@testable import Worksmile_app

final class PathViewModelTests: XCTestCase {

    private let service = MockPointsService(shouldFail: false)
    private var viewModel: PathViewModel!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()

        viewModel = PathViewModel(dependencies: .init(pointsService: service, anomalyInteractor: PathAnomalyInteractor()))
        disposeBag = DisposeBag()
    }

    func testCellViewModels() throws {
        waitForViewModelSetup()
        let points = try! service.fetchPoints()

        XCTAssertEqual(viewModel.numberOfSections(), 2, "Invalid number of sections")
        XCTAssertEqual(viewModel.numberOfItems(inSection: 0), 1, "Invalid number of items in section 0")
        XCTAssertEqual(viewModel.numberOfItems(inSection: 1), points.count, "Invalid number of items in section 1")
    }

    func testMapUpdate() throws {
        waitForViewModelSetup()
        let cell = viewModel.cellViewModel(forIndexPath: IndexPath(row: 0, section: 0))
        viewModel.input.view.didAction.onNext(.filterPressed)
        let newCell = viewModel.cellViewModel(forIndexPath: IndexPath(row: 0, section: 0))

        XCTAssert(cell !== newCell, "Map did not update")
    }

    func waitForViewModelSetup() {
        guard viewModel.numberOfSections() == 0 else { return }

        let exp = expectation(description: "viewModelSetup")

        viewModel.output.view.reloadData
            .take(1)
            .subscribe(onNext: {
                exp.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [exp], timeout: 2)
    }
}
