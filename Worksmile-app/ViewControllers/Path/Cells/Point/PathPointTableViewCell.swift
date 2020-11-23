//  
//  PathPointTableViewCell.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit

final class PathPointTableViewCell: TableViewCell<PathPointCellViewModel> {

    private let coordinateStaticLabel = UILabel()
    private let coordinateLabel = UILabel()

    private let distanceStaticLabel = UILabel()
    private let distanceLabel = UILabel()

    private let anomalyLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareComponent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configure(withViewModel viewModel: PathPointCellViewModel) {
        super.configure(withViewModel: viewModel)

        coordinateLabel.text = viewModel.output.cell.coordinateText
        distanceLabel.text = viewModel.output.cell.distanceText

        anomalyLabel.isHidden = viewModel.output.cell.anomalyIsHidden

        contentView.backgroundColor = viewModel.output.cell.cellBackgroundColor
    }
}

// MARK: - Preparation
private extension PathPointTableViewCell {
    func prepareComponent() {
        prepareConstraints()

        selectionStyle = .none

        coordinateStaticLabel.font = .systemFont(ofSize: 17, weight: .medium)
        coordinateStaticLabel.text = L10n.locPathCoordinateTitle

        coordinateLabel.font = .systemFont(ofSize: 15)

        distanceStaticLabel.font = .systemFont(ofSize: 17, weight: .medium)
        distanceStaticLabel.textAlignment = .right
        distanceStaticLabel.text = L10n.locPathDistanceTitle

        distanceLabel.font = .systemFont(ofSize: 15)
        distanceLabel.textAlignment = .right

        anomalyLabel.font = .systemFont(ofSize: 15, weight: .bold)
        anomalyLabel.textColor = .systemRed
        anomalyLabel.numberOfLines = 0
        anomalyLabel.text = L10n.locPathAnomalyInfo
    }

    func prepareConstraints() {
        let coordinateStackView = UIStackView(arrangedSubviews: [coordinateStaticLabel, coordinateLabel])
        coordinateStackView.axis = .vertical
        coordinateStackView.spacing = 4

        let distanceStackView = UIStackView(arrangedSubviews: [distanceStaticLabel, distanceLabel])
        distanceStackView.axis = .vertical
        distanceStackView.spacing = 4

        let infoStackView = UIStackView(arrangedSubviews: [coordinateStackView, distanceStackView])
        infoStackView.axis = .horizontal
        infoStackView.spacing = 16

        let mainStackView = UIStackView(arrangedSubviews: [infoStackView, anomalyLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 16

        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
