//
//  GetEventByIdRequestModel.swift
//  Prism
//
//  Created by user on 22.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

class PhotosInfoRequestModel: BaseRequestModel {
    
    override func createRequest() -> BaseRequest {
        return PhotosInfoRequest(with: self)
    }
}
