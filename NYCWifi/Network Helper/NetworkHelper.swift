//
//  NetworkHelper.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import Foundation

final class NetworkHelper {
    private init() {}
    static let shared = NetworkHelper()
    
    func performDataTask(endPointURLString: String,
                         httpMethod: String,
                         httpBody: Data?,
                         handler: @escaping (AppError?, Data?) -> Void) {
        guard let url = URL(string: endPointURLString) else {
            handler(AppError.badURL(endPointURLString), nil)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handler(AppError.networkError(error), nil)
            }
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                handler(AppError.badStatusCode(String(statusCode)), nil)
                return
            }
            if let data = data {
                handler(nil, data)
            }
        }
        task.resume()
    }
}
