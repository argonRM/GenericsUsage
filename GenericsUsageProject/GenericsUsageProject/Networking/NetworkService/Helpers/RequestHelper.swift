//
//  RequestHelper.swift
//  Prism
//
//  Created by user on 14.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

class RequestHelper<R: BaseRequestModel, S: BaseResponseModel> {
    var requestModel: R
    private var isLoading = false
    
    var loadingCallback: ((_ responseModel: S?) -> Void)?
    var errorCallback: (( _ error: Error?) -> Void)?
    
    init(with requestModel: R) {
        self.requestModel = requestModel
    }
    
    // MARK: Execution
    // Choose one of specified methods
    
    func fetch() {
        if isLoading  {
            return
        }
        
        isLoading = true
        
        NetworkManager.instance.dataTask(requestModel: requestModel, successBlock: { [weak self] (response: S?) in
            self?.isLoading = false
            self?.loadingCallback?(response)
        }) { [weak self] (error) in
            self?.isLoading = false
            self?.errorCallback?(error)
        }
    }
    
    func forceFetch() {
        NetworkManager.instance.dataTask(requestModel: requestModel, successBlock: { [weak self] (response: S?) in
                   self?.isLoading = false
                   self?.loadingCallback?(response)
               }) { [weak self] (error) in
                   self?.isLoading = false
                   self?.errorCallback?(error)
               }
    }
}


