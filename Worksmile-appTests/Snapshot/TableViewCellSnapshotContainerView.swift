//
//  TableViewCellSnapshotContainerView.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 23/11/2020.
//

import UIKit
import SnapKit
@testable import Worksmile_app

final class TableViewCellSnapshotContainerView<Cell: UITableViewCell>: UIView, UITableViewDataSource, UITableViewDelegate {
    typealias CellConfigurator = (_ cell: Cell) -> Void
    typealias HeightResolver = (_ width: CGFloat) -> CGFloat

    private let tableView = SnapshotTableView()
    private let configureCell: CellConfigurator
    private let heightForWidth: HeightResolver?

    /// Initializes container view for cell testing.
    ///
    /// - Parameters:
    ///   - width: Width of cell
    ///   - configureCell: closure which is passed to `tableView:cellForRowAt:` method to configure cell with content.
    ///   - cell: Instance of `Cell` dequeued in `tableView:cellForRowAt:`
    ///   - heightForWidth: closure which is passed to `tableView:heightForRowAt:` method to determine cell's height. When `nil` then `UITableView.automaticDimension` is used as cell's height. Defaults to `nil`.
    init(configureCell: @escaping CellConfigurator, width: CGFloat = UIScreen.main.bounds.width, heightForWidth: HeightResolver? = nil) {
        self.configureCell = configureCell
        self.heightForWidth = heightForWidth

        super.init(frame: .zero)

        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.greaterThanOrEqualTo(1)
        }

        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        tableView.tableFooterView = UIView()
        tableView.register(Cell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        configureCell(cell)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForWidth?(frame.width) ?? UITableView.automaticDimension
    }
}
