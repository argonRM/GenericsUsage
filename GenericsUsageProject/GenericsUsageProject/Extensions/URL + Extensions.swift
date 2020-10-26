//
//  URL + Extensions.swift
//  ReviewGenericsTest
//
//  Created by user on 4/26/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String : Any]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1 as? String) }
        return components?.url
    }
    
    func getQueryValue(by key: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == key })?.value
    }
}

extension URLRequest {
    
    private func percentEscapeString(_ string: Any) -> String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return (string as AnyObject)
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String : [Any]]) -> Data {
        httpMethod = "POST"
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, values) = arg
            var stringsArray = [String]()
            for value in values {
                stringsArray.append("\(key)=\(value)")
            }
            let str = stringsArray.joined(separator: "&")
            return str
        }
        
        let str = parameterArray.joined(separator: "&")
        let d = str.data(using: .utf8)!
        
        return d
    }
}
