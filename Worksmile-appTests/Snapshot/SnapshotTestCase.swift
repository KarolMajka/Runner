//
//  SnapshotTestCase.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 22/11/2020.
//

import XCTest
import FBSnapshotTestCase
import SnapKit

class SnapshotTestCase: FBSnapshotTestCase {

    var recordingMode: Bool {
        return false
    }

    override func setUp() {
        super.setUp()

        recordMode = recordingMode
    }

    func verifyView(view: UIView, useSnapshotContainerView: Bool = true, identifier: String? = nil, suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {

        let verifyView: UIView
        if useSnapshotContainerView {
            verifyView = SnapshotContainer(view: view)
        } else {
            verifyView = view
        }

        FBSnapshotVerifyView(verifyView, identifier: identifier, suffixes: suffixes, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance, file: file, line: line)
    }
}
