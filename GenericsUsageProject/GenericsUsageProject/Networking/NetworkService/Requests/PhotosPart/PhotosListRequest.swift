//
//  GetEventByIdRequest.swift
//  Prism
//
//  Created by user on 22.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

class PhotosInfoRequest: BaseRequest {
    
    static let path = "/photos"
    
    init(with model: PhotosInfoRequestModel) {
        super.init()
        
        self.path.append(PhotosInfoRequest.path)
        self.method = .get
        self.headersType = .base
        self.parametersType = .empty
    }
}
