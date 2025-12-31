//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import SwiftUI

/// Button style for transport bar action buttons
/// Uses glass effect on tvOS 18+ with press state feedback
/// Note: @Environment(\.isFocused) doesn't work reliably in ButtonStyle,
/// so we use configuration.isPressed for interaction feedback and show
/// a subtle background always to indicate interactivity.
struct TransportBarButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .foregroundStyle(.white)
            .padding(12)
            .background {
                #if os(tvOS)
                if #available(tvOS 18.0, *) {
                    Capsule()
                        .fill(.regularMaterial)
                        .opacity(configuration.isPressed ? 1.0 : 0.5)
                } else {
                    Capsule()
                        .fill(.white.opacity(configuration.isPressed ? 0.5 : 0.2))
                }
                #else
                Capsule()
                    .fill(.white.opacity(configuration.isPressed ? 0.5 : 0.2))
                #endif
            }
            .scaleEffect(configuration.isPressed ? 1.15 : 1.0)
            .animation(.spring(response: 0.2), value: configuration.isPressed)
    }
}
