//
//  File.swift
//  
//
//  Created by Julian Beck on 11.11.23.
//

import Foundation
import SwiftUI

public struct ThirdLaunchModifier: ViewModifier {
    @State private var isThirdLaunch: Bool = false
    let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
        let launchCountKey = "LaunchCount"
        var launchCount = UserDefaults.standard.integer(forKey: launchCountKey)
        launchCount += 1
        UserDefaults.standard.set(launchCount, forKey: launchCountKey)

        if launchCount == 3 {
            isThirdLaunch = true
        }
    }

    public func body(content: Content) -> some View {
        content
            .onAppear {
                if isThirdLaunch {
                    action()
                }
            }
    }
}

public extension View {
    func onThirdLaunch(perform action: @escaping () -> Void) -> some View {
        self.modifier(ThirdLaunchModifier(action: action))
    }
}
