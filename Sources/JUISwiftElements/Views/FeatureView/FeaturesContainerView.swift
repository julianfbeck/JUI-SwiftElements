//
//  FeaturesContainerView.swift
//  WhatStat
//
//  Created by Julian Beck on 14.03.21.
//  Copyright © 2021 Julian Beck. All rights reserved.
//

import SwiftUI

struct FeaturesContainerView: View {
   var features: [FeatureData]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(features, id: \.title) { feature in
                FeatureInfoView(
                    title: feature.title,
                    description: feature.description,
                    imageName: feature.imageName,
                    color: feature.color
                )
            }
        }
        .padding(.horizontal)
    }
}
