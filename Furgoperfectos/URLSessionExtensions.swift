//
//  URLSessionExtensions.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

extension URLSession {

    fileprivate static func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }

            do {
                let decodedData = try URLSession.newJSONDecoder().decode(T.self, from: data)
                completionHandler(decodedData, response, nil)
            } catch let error as NSError {
                completionHandler(nil, response, error)
            }

        }
    }

    func furgoperfectosResponseTask(with url: URL, completionHandler: @escaping ([FurgoperfectoModel]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
