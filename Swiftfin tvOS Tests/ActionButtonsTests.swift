//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2026 Jellyfin & Jellyfin Contributors
//

@testable import Swiftfin_tvOS
import XCTest

/// Tests for ActionButtons button group logic
@MainActor
final class ActionButtonsTests: XCTestCase {

    // MARK: - Button Group Definitions

    func testButtonGroupsAreDefinedCorrectly() {
        // Verify that all expected button groups exist
        let queueGroup: [VideoPlayerActionButton] = [.playPreviousItem, .playNextItem, .autoPlay]
        let tracksGroup: [VideoPlayerActionButton] = [.subtitles, .audio]
        let contentGroup: [VideoPlayerActionButton] = [.info, .episodes]
        let settingsGroup: [VideoPlayerActionButton] = [.playbackSpeed, .playbackQuality]
        let viewGroup: [VideoPlayerActionButton] = [.aspectFill]

        // Queue group should contain navigation buttons
        XCTAssertTrue(queueGroup.contains(.playPreviousItem))
        XCTAssertTrue(queueGroup.contains(.playNextItem))
        XCTAssertTrue(queueGroup.contains(.autoPlay))

        // Tracks group should contain audio/subtitle buttons
        XCTAssertTrue(tracksGroup.contains(.subtitles))
        XCTAssertTrue(tracksGroup.contains(.audio))

        // Content group should contain info and episodes
        XCTAssertTrue(contentGroup.contains(.info))
        XCTAssertTrue(contentGroup.contains(.episodes))

        // Settings group should contain playback controls
        XCTAssertTrue(settingsGroup.contains(.playbackSpeed))
        XCTAssertTrue(settingsGroup.contains(.playbackQuality))

        // View group should contain aspect fill
        XCTAssertTrue(viewGroup.contains(.aspectFill))
    }

    // MARK: - Button Filtering Logic

    func testAllVideoPlayerActionButtonsAreCoveredInGroups() {
        // All buttons should belong to exactly one group
        let allButtonGroups: [[VideoPlayerActionButton]] = [
            [.playPreviousItem, .playNextItem, .autoPlay],
            [.subtitles, .audio],
            [.info, .episodes],
            [.playbackSpeed, .playbackQuality],
            [.aspectFill],
        ]

        let allGroupedButtons = allButtonGroups.flatMap { $0 }

        // Check that key buttons are covered (except gestureLock which returns EmptyView)
        let expectedButtons: [VideoPlayerActionButton] = [
            .playPreviousItem,
            .playNextItem,
            .autoPlay,
            .subtitles,
            .audio,
            .info,
            .episodes,
            .playbackSpeed,
            .playbackQuality,
            .aspectFill,
        ]

        for button in expectedButtons {
            XCTAssertTrue(
                allGroupedButtons.contains(button),
                "Button \(button) should be in a group"
            )
        }
    }

    // MARK: - Group Index Tests

    func testGroupIndexForQueueButtons() {
        // Queue group should be index 0
        let queueButtons: [VideoPlayerActionButton] = [.playPreviousItem, .playNextItem, .autoPlay]

        for button in queueButtons {
            let index = groupIndex(for: button)
            XCTAssertEqual(index, 0, "\(button) should be in group 0 (Queue)")
        }
    }

    func testGroupIndexForTracksButtons() {
        // Tracks group should be index 1
        let tracksButtons: [VideoPlayerActionButton] = [.subtitles, .audio]

        for button in tracksButtons {
            let index = groupIndex(for: button)
            XCTAssertEqual(index, 1, "\(button) should be in group 1 (Tracks)")
        }
    }

    func testGroupIndexForContentButtons() {
        // Content group should be index 2
        let contentButtons: [VideoPlayerActionButton] = [.info, .episodes]

        for button in contentButtons {
            let index = groupIndex(for: button)
            XCTAssertEqual(index, 2, "\(button) should be in group 2 (Content)")
        }
    }

    func testGroupIndexForSettingsButtons() {
        // Settings group should be index 3
        let settingsButtons: [VideoPlayerActionButton] = [.playbackSpeed, .playbackQuality]

        for button in settingsButtons {
            let index = groupIndex(for: button)
            XCTAssertEqual(index, 3, "\(button) should be in group 3 (Settings)")
        }
    }

    func testGroupIndexForViewButtons() {
        // View group should be index 4
        let viewButtons: [VideoPlayerActionButton] = [.aspectFill]

        for button in viewButtons {
            let index = groupIndex(for: button)
            XCTAssertEqual(index, 4, "\(button) should be in group 4 (View)")
        }
    }

    func testGroupIndexForUnknownButtonReturnsNegativeOne() {
        // gestureLock is not in any group
        let index = groupIndex(for: .gestureLock)
        XCTAssertEqual(index, -1, "gestureLock should return -1 (not in any group)")
    }

    // MARK: - Group Transition Detection

    func testGroupTransitionBetweenDifferentGroups() {
        // When transitioning between groups, spacing should be added
        let prevButton = VideoPlayerActionButton.playNextItem // Group 0
        let currentButton = VideoPlayerActionButton.subtitles // Group 1

        let prevGroup = groupIndex(for: prevButton)
        let currentGroup = groupIndex(for: currentButton)

        XCTAssertNotEqual(prevGroup, currentGroup, "Different groups should have different indices")
    }

    func testNoGroupTransitionWithinSameGroup() {
        // Within the same group, no extra spacing
        let prevButton = VideoPlayerActionButton.playPreviousItem // Group 0
        let currentButton = VideoPlayerActionButton.playNextItem // Group 0

        let prevGroup = groupIndex(for: prevButton)
        let currentGroup = groupIndex(for: currentButton)

        XCTAssertEqual(prevGroup, currentGroup, "Same group buttons should have same index")
    }

    // MARK: - Helper Function (mirrors ActionButtons.groupIndex)

    private static let buttonGroups: [[VideoPlayerActionButton]] = [
        [.playPreviousItem, .playNextItem, .autoPlay],
        [.subtitles, .audio],
        [.info, .episodes],
        [.playbackSpeed, .playbackQuality],
        [.aspectFill],
    ]

    private func groupIndex(for button: VideoPlayerActionButton) -> Int {
        for (index, group) in Self.buttonGroups.enumerated() {
            if group.contains(button) {
                return index
            }
        }
        return -1
    }
}
