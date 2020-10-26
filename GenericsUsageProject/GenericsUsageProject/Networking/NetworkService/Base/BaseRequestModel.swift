//
//  BaseRequestModel.swift
//  Prism
//
//  Created by user on 14.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

class BaseRequestModel {
    
    func createRequest() -> BaseRequest{
        return BaseRequest()
    }
}

class BasePagingRequestModel: BaseRequestModel {
    var page: Int
    
    init(with page: Int) {
        self.page = page
    }
}

class BaseUrlPagingRequestModel: BaseRequestModel {
    var currentUrl: URL?
    var isNextExist = false
    var parameters = [String: Any]()
}
