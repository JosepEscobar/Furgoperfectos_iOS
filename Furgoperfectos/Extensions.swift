//
//  Extensions.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 12/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            fatalError("Did not get data in response")
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}

extension String {
    func utf8DecodedString()-> String {
        let messageData = self.data(using: .utf8)
        if let message = String(data: messageData!, encoding: .nonLossyASCII){
            return message
        }
        return ""
    }

    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let message = String(data: messageData!, encoding: .utf8)
        return message ?? ""
    }
}

extension UIImage {
    
    func filled(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = self.cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    static let pin = UIImage(named: "pin")?.filled(with: .green)
    static let pin2 = UIImage(named: "pin2")?.filled(with: .green)
    static let me = UIImage(named: "me")?.filled(with: .blue)
    
}

extension UIColor {
    static let unicycleColor = UIColor(named: "unicycleColor")
    static let bicycleColor = UIColor(named: "bicycleColor")
    static let tricycleColor = UIColor(named: "tricycleColor")
    static let translucentButtonColor = UIColor(named: "translucentButton")
}
