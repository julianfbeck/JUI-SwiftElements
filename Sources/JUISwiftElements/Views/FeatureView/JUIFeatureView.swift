//
//  ProScreen.swift
//  WhatStat
//
//  Created by Julian Beck on 14.03.21.
//  Copyright © 2021 Julian Beck. All rights reserved.
//


import SwiftUI
public struct FeatureData {
    let title: String
    let description: String
    let imageName: String
    let color: Color
    
    
    
    public init(title: String, description: String, imageName: String, color: Color ) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.color = color
    }
}
// MARK: - FeatureView
/* Usage
 JUIFeatureView(name: "Test", subtext: "subtext", features: []){
 print("button has been pressed")
 }
 */
public struct JUIFeatureView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var name: String
    var subtext : String
    var features: [FeatureData]
    var buttonColor: Color
    var dismissAfterAction = true
    var buttonText: String
    var onButtonPressed: () -> Void
    
    
    public init(name: String, subtext: String, features: [FeatureData], buttonText: String, buttonColor: Color, onButtonPressed: @escaping () -> Void) {
        self.name = name
        self.subtext = subtext
        self.features = features
        self.onButtonPressed = onButtonPressed
        self.buttonText = buttonText
        self.buttonColor = buttonColor
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 32) {
                        TitleView(name: name, subtext: subtext, color: buttonColor)
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
                                Text(buttonText)
                                    .font(.system(size: 20, weight: .heavy))
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
