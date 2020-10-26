//
//  BaseRequest.swift
//  Prism
//
//  Created by user on 14.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

 enum MyHTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HeadersType {
    case base
    case formData
    case withJSON
    case withMultipart
}

enum ParametersType {
    case encodeParametersType
    case bodyParametyersType
    case withDataParametersType
    case postRequestWithQuery
    case empty
}

class BaseRequest {
   
    static let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    var path: String = ""
    var method: MyHTTPMethod = .get
    var parameters: [String: Any] = [:]
    var headers: [String: String] = [:]
    var data: Data?
    var skipCheckResponse = false
    var parametersType: ParametersType = .encodeParametersType
    var headersType: HeadersType = .base
    var additionalPathInTheEnd = ""
    var mimeType = ""
    var pathExtension = ""
    var multipartImageKey = "image"
    
    func createRequest() -> URLRequest {
        var url = BaseRequest.baseURL
        url.appendPathComponent(path)
        
        var urlWithQueries = url
        var request = URLRequest(url: urlWithQueries)
        
        switch method {
        case .get, .delete:
            if !parameters.isEmpty {
                urlWithQueries = url.withQueries(parameters)!
                request = URLRequest(url: urlWithQueries)
            }
        case .post, .put, .patch:
            if parametersType == .postRequestWithQuery {
                urlWithQueries = url.withQueries(parameters)!
                request = URLRequest(url: urlWithQueries)
            }
            break
        }
        
        let boundary = generateBoundaryString()
        
        switch headersType {
        case .base:
            headers = ["Accept" : "application/json",
                       "Content-Type" : "application/json"]
        case .formData:
            headers = ["Accept" : "application/json",
                       "Content-Type" : "application/json",
                       "content-Type" : "application/x-www-form-urlencoded"]
        case .withJSON:
            headers = ["Accept" : "application/json",
                       "Content-Type" : "application/json"]
        case .withMultipart:
            headers = ["content-type": "multipart/form-data; boundary=\(boundary)"]
        }
        
        if NetworkManager.instance.authToken != "" {
            headers["Authorization"] = "Bearer \(NetworkManager.instance.authToken)"
        }
        
        switch parametersType {
        case .encodeParametersType:
            if let params = parameters as? [String: [Any]] {
                let d = request.encodeParameters(parameters: params)
                request.httpBody = d
            }
        case .bodyParametyersType:
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
                data = jsonData
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        case .withDataParametersType:
                let filename = "newFile" + "." + pathExtension
                let bodyData = createBodyWithParameters(boundary: boundary,
                                                    data: data,
                                                    mimeType: mimeType,
                                                    filename: filename,
                                                    imageKey: "image",
                                                    parameters: parameters)
                request.httpBody = bodyData
        case .postRequestWithQuery, .empty:
            break
        }
        
        if additionalPathInTheEnd != "" {
            let urlAbsoluteString = request.url?.absoluteString
            let aupdatedUrlPath = urlAbsoluteString! + additionalPathInTheEnd
            request.url = URL(string: aupdatedUrlPath)
        }
    
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

extension BaseRequest {
    func createBodyWithParameters(boundary: String,
                                  data: Data?,
                                  mimeType: String,
                                  filename: String,
                                  imageKey: String? = nil,
                                  parameters: [String : Any]? = nil) -> Data? {
        var body = ""
        
        if let params = parameters {
            for (key, value) in params {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"")
                
                if let strValue = value as? String {
                    body.append("\r\n\r\n")
                    body.append(strValue)
                    body.append("\r\n")
                }
                if let intValue = value as? Int {
                    body.append("\r\n\r\n")
                    body.append(String(intValue))
                    body.append("\r\n")
                }
                if let boolValue = value as? Bool {
                    body.append("\r\n\r\n")
                    body.append(String(boolValue))
                    body.append("\r\n")
                }
                if let doubleValue = value as? Double {
                    body.append("\r\n\r\n")
                    body.append(String(doubleValue))
                    body.append("\r\n")
                }
                if let intValueArray = value as? [Int] {
                    let strings = intValueArray.map { (str) -> String in
                        return String(str)
                    }
                    let finalStr = strings.joined(separator: ", ")
                    body.append("\r\n\r\n")
                    body.append(finalStr)
                    body.append("\r\n")
                }
            }
        }
        
        if let myData = data {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(multipartImageKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimeType)\r\n\r\n")
            var finalData = body.data(using: String.Encoding.utf8, allowLossyConversion: true)!
            finalData.append(myData)
            finalData.appendString("\r\n")
            finalData.appendString("--".appending(boundary.appending("--")))
            
            return finalData
        } else {
            var finalData = body.data(using: String.Encoding.utf8, allowLossyConversion: true)!
            finalData.appendString("--".appending(boundary.appending("--")))
            
            return finalData
        }
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
