//
//  File.swift
//
//
//  Created by Julian Beck on 11.11.23.
//

import Foundation
import SwiftUI
public struct FirstLaunchAsyncModifier: ViewModifier {
    @State private var isFirstLaunch: Bool = false
    let asyncAction: () async -> Void
    
    public init(asyncAction: @escaping () async -> Void) {
        self.asyncAction = asyncAction
        // Check if the app is launched for the first time
        if UserDefaults.standard.bool(forKey: "HasLaunchedBefore") == false {
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
            UserDefaults.standard.synchronize()
            isFirstLaunch = true
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .task {
                if isFirstLaunch {
                    await asyncAction()
                }
            }
    }
}

public struct FirstLaunchModifier: ViewModifier {
    @State private var isFirstLaunch: Bool = false
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
        // Check if the app is launched for the first time
        if UserDefaults.standard.bool(forKey: "HasLaunchedBefore") == false {
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
            UserDefaults.standard.synchronize()
            isFirstLaunch = true
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if isFirstLaunch {
                    action()
                }
            }
    }
}

public extension View {
    func onFirstLaunchTask(perform asyncAction: @escaping () async -> Void) -> some View {
        self.modifier(FirstLaunchAsyncModifier(asyncAction: asyncAction))
    }
    func onFirstLaunch(perform action: @escaping () -> Void) -> some View {
        self.modifier(FirstLaunchModifier(action: action))
    }
}
