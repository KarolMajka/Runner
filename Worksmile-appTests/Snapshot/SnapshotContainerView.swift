//
//  SnapshotContainerView.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 23/11/2020.
//

import UIKit
import SnapKit

final class SnapshotContainer: UIView {
    private let view: UIView

    init(view: UIView, width: CGFloat = UIScreen.main.bounds.width) {
        self.view = view

        super.init(frame: .zero)

        addSubview(view)

        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
