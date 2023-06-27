//
//  ProScreen.swift
//  WhatStat
//
//  Created by Julian Beck on 14.03.21.
//  Copyright © 2021 Julian Beck. All rights reserved.
//


import SwiftUI
public struct Feature {
    let title: String
    let description: String
    let imageName: String
}
// MARK: - FeatureView
/* Usage
 JUIFeatureView(name: "Test", subtext: "subtext", features: []){
    print("button has been pressed")
 }
*/
public struct JUIFeatureView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    public var name: String
    public var subtext : String
    public var features: [Feature]
    public var buttonColor: Color = .blue
    public var dismissAfterAction = true
    public var onButtonPressed: () -> Void
    
    
    public init(name: String, subtext: String, features: [Feature], onButtonPressed: @escaping () -> Void) {
        self.name = name
        self.subtext = subtext
        self.features = features
        self.onButtonPressed = onButtonPressed
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 32) {
                        TitleView(name: name, subtext: subtext)
                        FeaturesContainerView(features: features)
                        Spacer()
                        
                        Button {
                            onButtonPressed()
                            if dismissAfterAction {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 55)
                                    .foregroundColor(buttonColor)
                                    .cornerRadius(10)
                                Text("Test")
                                    .foregroundColor(.white)
                            }
                            
                        }.padding()
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}) { Image(systemName: "xmark.circle.fill")
                .font(.system(size: 20, weight: .heavy)) })
            
        }
    }
    
}
