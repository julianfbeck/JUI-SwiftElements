//
//  File.swift
//  
//
//  Created by Julian Beck on 11.09.23.
//

import Foundation


public enum PlausibleError: Error {
    case domainNotSet
    case invalidDomain
    case eventIsPageview
}

/// PlausibleSwift is an implementation of the Plausible Analytics REST events API as described here: https://plausible.io/docs/events-api
public class PlausibleSwift {
    public private(set) var endpoint = ""
    public private(set) var domain = ""

    
    public init(domain: String, endpoint: String) {
        self.endpoint = endpoint
        self.domain = domain
    }
    
    
    /// Sends a pageview event to Plausible for the specified path
    /// - Parameters:
    ///     - path: a URL path to use as the pageview location (as if it was viewed on a website). There doesn't have to be anything served at this URL.
    ///     - properties: (optional) a dictionary of key-value pairs that will be attached to this event
    /// Throws a `domainNotSet` error if it has been configured with an empty domain
    public func trackPageview(path: String, properties: [String: String] = [:]) async {
        guard self.domain != "" else {
            return
        }
        do {
           try await plausibleRequest(name: "pageview", path: path, properties: properties)
        } catch {
            print(error)
        }
    }
    /// Sends a named event to Plausible for the specified path
    /// - Parameters:
    ///     - event: an arbitrary event name for your analytics.
    ///     - path: a URL path to use as the pageview location (as if it was viewed on a website). There doesn't have to be anything served at this URL.
    ///     - properties: (optional) a dictionary of key-value pairs that will be attached to this event
    /// Throws a `domainNotSet` error if it has been configured with an empty domain.
    /// Throws a `eventIsPageview` error if you try to specific the event name as `pageview` which may indicate that you're holding it wrong.
    public func trackEvent(event: String, path: String, properties: [String: String] = [:]) async {
        guard event != "pageview" else {
            return
        }
        do {
            try await plausibleRequest(name: event, path: path, properties: properties)
        } catch {
            print(error)
        }
    }
    
    private func plausibleRequest(name: String, path: String, properties: [String: String]) async throws {
        guard let plausibleEventURL = URL(string: self.endpoint) else {
            throw PlausibleError.invalidDomain
        }

        var req = URLRequest(url: plausibleEventURL)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonObject: [String: Any] = ["name": name,"url": constructPageviewURL(path: path),"domain": domain]
        if !properties.isEmpty {
            jsonObject["props"] = properties
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        req.httpBody = jsonData

        
        let (data, response) = try await URLSession.shared.data(for: req)
    }
    
    internal func constructPageviewURL(path: String) -> String {
        let url = URL(string: "https://\(domain)")!

        // TODO: replace with iOS 16-only path methods at some point
        return url.appendingPathComponent(path).absoluteString
    }
}
    
