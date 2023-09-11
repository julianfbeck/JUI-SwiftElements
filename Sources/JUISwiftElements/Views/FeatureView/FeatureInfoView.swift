//
//  FeatureInfoView.swift
//  WhatStat
//
//  Created by Julian Beck on 14.03.21.
//  Copyright © 2021 Julian Beck. All rights reserved.
//

import SwiftUI

struct FeatureInfoView: View {

    var title = "Seamless Transitions"
    var description = "120 Hz refresh rate"
    var imageName = "battery.100"
    var color: Color = .blue

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(color)
                .padding()
                .accessibility(hidden: true)
                .frame(minWidth: 88)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct FeatureInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureInfoView()
    }
}
