//
//  URLSessionExtensions.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation
import warqLog

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
                WarqLog.debug(response)
                //WarqLog.debug(String(data: data, encoding: .utf8) ?? "NO RESPONSE")
                let decodedData = try URLSession.newJSONDecoder().decode(T.self, from: data)
                completionHandler(decodedData, response, nil)
            } catch let error as NSError {
                WarqLog.error(error.localizedDescription)
                completionHandler(nil, response, error)
            }

        }
    }

    func furgoperfectosResponseTask(with url: URL, completionHandler: @escaping ([FurgoperfectoDataModel]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
