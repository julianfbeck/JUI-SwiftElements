//
//  TitleView.swift
//  WhatStat
//
//  Created by Julian Beck on 14.03.21.
//  Copyright © 2021 Julian Beck. All rights reserved.
//

import SwiftUI

import SwiftUI

struct TitleView: View {
    var name: String
    var subtext: String

    var body: some View {
        VStack {

            VStack(alignment: .leading) {
                Text(name)
                    .fontWeight(.black)
                    .font(.system(size: 36))

                Text(subtext)
                    .fontWeight(.black)
                    .font(.system(size: 36))
                    .foregroundColor(.blue)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(name: "test", subtext: "test")
    }
}
