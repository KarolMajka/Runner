//  
//  PathViewController.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class PathViewController: ViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let filterButton = UIButton(type: .system)

    var viewModel: PathViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViewController()
        setupRxObservers()
    }
}

// MARK: - Preparation
private extension PathViewController {
    func prepareViewController() {
        prepareConstraints()

        title = L10n.locPathTitle
        view.backgroundColor = .white

        tableView.contentInset.bottom = 62
        tableView.tableFooterView = UIView()

        tableView.register(PathMapTableViewCell.self)
        tableView.register(PathPointTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        filterButton.backgroundColor = .systemGreen
        filterButton.layer.cornerRadius = 8
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.setTitle(L10n.locPathAnomalyButtonTitle, for: .normal)
    }

    func prepareConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.height.equalTo(46)
        }
    }
}

// MARK: - RxObservers
private extension PathViewController {
    func setupRxObservers() {
        viewModel.output.view.reloadData
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: tableView.rx.reloadData)
            .disposed(by: disposeBag)

        filterButton.rx.tap
            .map { .filterPressed }
            .bind(to: viewModel.input.view.didAction)
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension PathViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.view.didAction.onNext(.itemPressed(indexPath))
    }
}

// MARK: - UITableViewDataSource
extension PathViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)

        switch cellViewModel {
        case let cellViewModel as PathMapCellViewModel:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PathMapTableViewCell
            cell.configure(withViewModel: cellViewModel)
            return cell
        case let cellViewModel as PathPointCellViewModel:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PathPointTableViewCell
            cell.configure(withViewModel: cellViewModel)
            return cell
        default:
            print("Unhandled CellViewModel type: \(cellViewModel.self).")
            return UITableViewCell()
        }
    }
}
