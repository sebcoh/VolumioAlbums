//
//  ParseHelper.swift
//  WStest
//
//  Created by Sebastian Cohausz on 12.08.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation
struct ParseHelper {
    static func toJSON(input: Any) -> Data? {
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: input)
        } catch {
            return nil
            //error!
        }
        return data
    }
    
    static func drillDownToData(input: [Any]) -> [Any] {
        let first = input[0] as! Dictionary<String, Any>
        let navigation = first["navigation"] as! Dictionary<String, Any>
        let lists = navigation["lists"] as! [Dictionary<String, Any>]
        return lists[0]["items"] as! [Any]
    }
    
    static func decodeItems<ResultType: Decodable>(input: [Any]) -> [ResultType] {
        let items = drillDownToData(input: input)
        guard let jsonData = toJSON(input: items) else {
            print("error parsing to json")
            return []
        }
        do {
            
            let decoder = JSONDecoder()
            return try decoder.decode([ResultType].self, from: jsonData)
        } catch {
            print("error parsing \(ResultType.self): \(error)")
            return []
        }
    }
}
