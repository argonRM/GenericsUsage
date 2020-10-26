//
//  BaseResponseModel.swift
//  Prism
//
//  Created by user on 14.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

class BaseResponseModel: Decodable {
  
}

class BaseResponsePagingUrlModel: BaseResponseModel {
    var next, previous: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
        case previous = "previous"
        case count = "count"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        guard let decoderContainer = container else {
            return
        }
        
        next = try? decoderContainer.decode(String.self, forKey: .next)
        previous = try? decoderContainer.decode(String.self, forKey: .previous)
        count = try? decoderContainer.decode(Int.self, forKey: .count)
    }
}

class ArrayResponse <T: Decodable> : BaseResponseModel {
    var array: [T]?
    
    required init(from decoder: Decoder) throws {
        super.init()
        
        let singleContainer = try? decoder.singleValueContainer()
        do {
            array = try singleContainer?.decode([T].self)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

class ItemResponse <T: Decodable> : BaseResponseModel {
    var item: T?
    
    required init(from decoder: Decoder) throws {
        super.init()
        
        let singleContainer = try? decoder.singleValueContainer()
        do {
            item = try singleContainer?.decode(T.self)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
