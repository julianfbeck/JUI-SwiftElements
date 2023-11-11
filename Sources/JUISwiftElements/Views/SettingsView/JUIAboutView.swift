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
    public var privacyPolicyLink: String
    public var termsOfServiceLink: String
    public var highlightColor: Color
    
    public init(mailLink: String, privacyPolicyLink: String, termsOfServiceLink: String, highlightColor: Color = .blue) {
        self.mailLink = mailLink
        self.privacyPolicyLink = privacyPolicyLink
        self.termsOfServiceLink = termsOfServiceLink
        self.highlightColor = highlightColor
    }

    public var body: some View {
        Group {
            Section {
                AboutViewItem(sfSymbol: "lock", header: String(localized: "Privacy Policy"), subtext: String(localized: "Read our privacy policy"), highlightColor: highlightColor) {
                    UIApplication.shared.open(URL(string: privacyPolicyLink)!)
                }
                AboutViewItem(sfSymbol: "doc.text", header: String(localized: "Terms of Service"), subtext: String(localized: "Read our terms of service"), highlightColor: highlightColor) {
                    UIApplication.shared.open(URL(string: termsOfServiceLink)!)
                }
            } header: {
                Text(String(localized: "Legal")).textCase(nil).font(.title2).fontWeight(.bold)
            }

            Section {
                AboutViewItem(sfSymbol: "link", header: String(localized: "My Twitter"), subtext: String(localized: "Reach out to me"), highlightColor: highlightColor) {
                    UIApplication.shared.open(URL(string: "https://twitter.com/julianfbeck")!)
                }
                AboutViewItem(sfSymbol: "envelope", header: String(localized: "Give Feedback"), subtext: String(localized: "Send me an email"), highlightColor: highlightColor) {
                    UIApplication.shared.open(URL(string: "mailto:\(mailLink)")!)
                }
                AboutViewItem(sfSymbol: "envelope", header: String(localized: "My Website"), subtext: String(localized: "Check out my Website"), highlightColor: highlightColor) {
                    UIApplication.shared.open(URL(string: "https://juli.sh")!)
                }
                
            } header: {
                Text(String(localized: "Get in Touch")).textCase(nil).font(.title2).fontWeight(.bold)
            }

            Section {
                AboutViewItem(sfSymbol: "star.fill", header: String(localized: "Rate and Review"), subtext: String(localized: "Rate and review this app on the App Store"), highlightColor: highlightColor) {
                    requestReview()
                }
            } header: {
                Text(String(localized: "Send Some Love")).textCase(nil).font(.title2).fontWeight(.bold)
            }
        }.listStyle(.insetGrouped)
        
    }
}
struct AboutViewItem: View {
    var sfSymbol: String
    var header: String
    var subtext: String
    var highlightColor: Color
    let onClick: () -> Void

    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Image(systemName: sfSymbol).roundedColoredSfSymbol(size: 22, color: highlightColor)
                VStack(alignment: .leading) {
                    Text(header).font(.headline).fontWeight(.bold)
                    Text(subtext).font(.caption).foregroundColor(.gray).fontWeight(.bold)
                }
                Spacer()
            }.padding(.vertical,1).contentShape(Rectangle())

            
        }.buttonStyle(.plain)
    }
}



struct JUIAboutView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            JUIAboutView(mailLink: "bexk@juli.sh", privacyPolicyLink: "https://juli.sh/privacy", termsOfServiceLink: "https://juli.sh/terms")
        }
    }
}
