//
//  SwiftUIView.swift
//  
//
//  Created by Julian Beck on 27.06.23.
//

import SwiftUI
import StoreKit

public struct JUIAboutView: View {
    @Environment(\.requestReview) var requestReview
    public var mailLink: String
    public init(mailLink: String) {
        self.mailLink = mailLink
    }
    public var body: some View {
        Group {
            Section {
                AboutViewItem(sfSymbol: "link", header: "My Twitter", subtext: "Reach out to me") {
                    UIApplication.shared.open(URL(string: "https://twitter.com/julianfbeck")!)
                }
                AboutViewItem(sfSymbol: "envelope", header: "Give Feedback", subtext: "Send me an email") {
                    UIApplication.shared.open(URL(string: "mailto:\(mailLink)")!)
                }
                AboutViewItem(sfSymbol: "envelope", header: "My Website", subtext: "Check out my Website") {
                    UIApplication.shared.open(URL(string: "https://juli.sh")!)
                }
            } header: {
                Text("Get in Touch").textCase(nil).font(.title2).fontWeight(.bold)
            }
            Section {
                AboutViewItem(sfSymbol: "star.fill", header: "Rate and Review", subtext: "Rate and review this app on the App Store") {
                    requestReview()
                }
            } header: {
                Text("Send Some Love").textCase(nil).font(.title2).fontWeight(.bold)
            }
        }.listStyle(.insetGrouped)
        
    }
}

struct AboutViewItem: View {
    var sfSymbol: String
    var header: String
    var subtext: String
    let onClick: () -> Void
    var body: some View {
        HStack {
            Image(systemName: sfSymbol).roundedColoredSfSymbol(size: 22, color: .blue)
            VStack(alignment: .leading) {
                Text(header).font(.headline).fontWeight(.bold)
                Text(subtext).font(.caption).foregroundColor(.gray).fontWeight(.bold)
            }
        }.padding(.vertical,1)
        
    }
}



struct JUIAboutView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            JUIAboutView(mailLink: "bexk@juli.sh")
        }
    }
}