//
//  NSObjectExtension.swift
//  Ouch
//
//  Created by Rahul Mane on 06/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

extension NSObject {
    func getJSONObject<T : Encodable>(obj : T)->[String : Any]?{
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do{
            let jsonData = try jsonEncoder.encode(obj)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
            return json as? [String : Any]
        }
        catch{
        }
        return nil
    }
}
