//  
//  PathMapTableViewCell.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit
import MapKit

final class PathMapTableViewCell: TableViewCell<PathMapCellViewModel> {

    private let mapView = MKMapView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareComponent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        mapView.removeOverlays(mapView.overlays)
    }

    override func configure(withViewModel viewModel: PathMapCellViewModel) {
        super.configure(withViewModel: viewModel)

        if let route = viewModel.output.cell.route {
            mapView.addOverlay(route)
            if viewModel.output.cell.camera == nil {
                let padding: CGFloat = 64
    
                mapView.setVisibleMapRect(
                    route.boundingMapRect,
                    edgePadding: .init(top: padding, left: padding, bottom: padding, right: padding),
                    animated: false
                )
            }
        }
        if let camera = viewModel.output.cell.camera {
            mapView.camera = camera
        }
    }
}

// MARK: - Preparation
private extension PathMapTableViewCell {
    func prepareComponent() {
        selectionStyle = .none

        contentView.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(300).priority(.high)
        }

        mapView.delegate = self
    }
}

// MARK: - MKMapViewDelegate
extension PathMapTableViewCell: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        cellViewModel?.output.cell.camera = mapView.camera
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        switch overlay {
        case let polyline as MKPolyline:
            let render = MKPolylineRenderer(polyline: polyline)
            render.lineWidth = 3
            render.strokeColor = .systemGreen
            return render
        default:
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
