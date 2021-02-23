//
//  AppError.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case jsonDecodingError(Error)
    case networkError(Error)
    case badStatusCode(String)
    case propertyListingEncodingError(Error)
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let message):
            return "Bad URL: \(message)"
        case .jsonDecodingError(let error):
            return "JSON decoding error: \(error)"
        case .networkError(let error):
            return "Network Error \(error)"
        case .badStatusCode(let message):
            return "Bad status code: \(message)"
        case .propertyListingEncodingError(let error):
            return "Property list encoding error: \(error)"
        }
    }
}
