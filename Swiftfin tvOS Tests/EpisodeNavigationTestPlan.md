# Episode Navigation Test Plan

This document outlines test cases for the episode navigation improvements. These can be executed manually on an Apple TV device/simulator, or automated when a UI test target is added.

## Prerequisites

- Apple TV (physical or simulator)
- Jellyfin server with TV series content
- At least one series with multiple seasons and episodes
- At least one partially watched episode (for "Continue" indicator testing)

---

## Test Cases

### NAV-001: Transport Bar Right Navigation

**Objective**: Verify all transport bar buttons are reachable via right D-pad navigation.

**Steps**:
1. Start playing an episode
2. Press Select or swipe down to show overlay
3. Focus should be on an action button
4. Press Right on the remote repeatedly

**Expected Result**:
- Focus moves through all visible action buttons from left to right
- No focus "dead zones" where navigation stops
- All buttons including Next Episode, Subtitles, Audio, Info, Episodes, Speed, Quality, Aspect are reachable

**Pass Criteria**: All visible buttons receive focus when navigating right.

---

### NAV-002: Transport Bar Left Navigation

**Objective**: Verify left navigation through transport bar buttons.

**Steps**:
1. Start playing an episode, show overlay
2. Navigate right to the rightmost button (Aspect Fill)
3. Press Left on the remote repeatedly

**Expected Result**:
- Focus moves back through all buttons from right to left
- Reaches the leftmost button (Previous Episode if queue exists)

**Pass Criteria**: All buttons are reachable via left navigation.

---

### NAV-003: Episode Picker Reachable from Series Detail

**Objective**: Verify users can navigate from Play button to episode selector.

**Steps**:
1. Navigate to a TV series detail page
2. Observe the header with Play button
3. Look for "Episodes" label with down chevron indicator
4. Press Down on the remote from the Play button area

**Expected Result**:
- Season buttons become visible and focused
- The scroll view animates to show the episode selector
- "Episodes" scroll indicator is visible at bottom of header

**Pass Criteria**: Episode selector is discoverable and reachable.

---

### NAV-004: Season/Episode Label in Player Overlay

**Objective**: Verify season and episode information displays correctly during playback.

**Steps**:
1. Start playing an episode (e.g., Season 2, Episode 5 of "Breaking Bad")
2. Show the overlay (press Select or wait for controls)
3. Look at the top-left corner

**Expected Result**:
- Season/Episode label visible (e.g., "Season 2, Episode 5" or "S2E5")
- Series name visible (e.g., "Breaking Bad")
- Episode title visible (e.g., "Buyout")
- Year visible if available (e.g., "2012")

**Pass Criteria**: All metadata displays correctly for episodes.

---

### NAV-005: Movie Metadata (Non-Episode)

**Objective**: Verify movies still display correctly without episode metadata.

**Steps**:
1. Start playing a movie
2. Show the overlay

**Expected Result**:
- Movie title displays prominently
- Year displays below title
- No season/episode labels (correct - it's a movie)

**Pass Criteria**: Movie metadata displays without episode-specific info.

---

### NAV-006: Continue Indicator on Series Detail

**Objective**: Verify "Continue: S#E#" indicator shows for series with progress.

**Steps**:
1. Navigate to a TV series you've partially watched
2. Look at the metadata area below the logo/title

**Expected Result**:
- "Continue" label visible
- Season/Episode label (e.g., "S2E5")
- Episode title (e.g., "Buyout")

**Pass Criteria**: Continue indicator shows the correct next episode.

---

### NAV-007: Season Navigation

**Objective**: Verify horizontal navigation between season buttons.

**Steps**:
1. Navigate to a series with multiple seasons
2. Scroll down to the episode selector
3. Focus should be on a season button
4. Press Left/Right to change seasons

**Expected Result**:
- Focus moves between season buttons
- Selected season changes the episode list below
- Auto-scroll positions the selected season button in view

**Pass Criteria**: Season selection works correctly.

---

### NAV-008: Episode Card Navigation

**Objective**: Verify navigation within episode list.

**Steps**:
1. Navigate to a series, scroll to episode selector
2. Press Down to focus episode cards
3. Press Left/Right to browse episodes

**Expected Result**:
- Focus moves between episode cards
- Episode cards show poster, progress bar (if watched), watched indicator
- Pressing Select starts playback

**Pass Criteria**: Episode browsing and selection works.

---

### NAV-009: Bidirectional Focus (Episodes ↔ Seasons ↔ Header)

**Objective**: Verify focus can move back up from episodes to header.

**Steps**:
1. Navigate to episode cards
2. Press Up to return to season buttons
3. Press Up again to return to header/Play button

**Expected Result**:
- Focus transitions correctly between all sections
- No focus traps (can always navigate back up)

**Pass Criteria**: Bidirectional navigation works.

---

## Future UI Test Implementation

When a UI test target is added (`Swiftfin tvOS UITests`), implement:

```swift
import XCTest

class EpisodeNavigationUITests: XCTestCase {

    func testTransportBarRightNavigation() {
        let app = XCUIApplication()
        app.launch()
        // Navigate to episode, start playback
        // Show overlay
        // Navigate right through all buttons
        // Assert each expected button becomes focused
    }

    func testEpisodeSelectorFromSeriesDetail() {
        let app = XCUIApplication()
        app.launch()
        // Navigate to series
        // Press down from header
        // Assert season selector is visible and focused
    }

    func testSeasonEpisodeLabelInOverlay() {
        let app = XCUIApplication()
        app.launch()
        // Play an episode
        // Show overlay
        // Assert "S#E#" text exists
        // Assert series name exists
    }
}
```

---

## Test Environment Notes

- **tvOS Simulator**: Use Xcode's tvOS simulator for quick testing
- **Apple TV Hardware**: Required for final validation (remote behavior differs)
- **Focus Debugging**: Enable "Show Focus" in Xcode to visualize focus changes
- **Accessibility Inspector**: Use to verify focus order and element hierarchy
