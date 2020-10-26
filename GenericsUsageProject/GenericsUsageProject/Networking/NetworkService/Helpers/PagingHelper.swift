//
//  PagingHelper.swift
//  Prism
//
//  Created by user on 14.01.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

protocol PagingDelegate {
    func next()
}

class PagingHelper<R: BasePagingRequestModel, S: BaseResponseModel> {
    var currentPage = 0
    var nextUrl: URL?
    private var requestModel: R
    private var isLoading = false
    
    var loadingCallback: ((_ responseModel: S?) -> Void)?
    var errorCallback: (( _ error: Error?) -> Void)?
    
    init(with requestModel: R) {
        self.requestModel = requestModel
    }
    
    func fetchNext() {
        if isLoading  {
            return
        }
        
        isLoading = true
        
        requestModel.page = currentPage
        
        NetworkManager.instance.dataTask(requestModel: requestModel, successBlock: { [weak self] (response: S?) in
            self?.currentPage += 1
            self?.isLoading = false
            self?.loadingCallback?(response)
        }) { [weak self] (error) in
            self?.currentPage -= 1
            self?.isLoading = false
            self?.errorCallback?(error)
        }
    }
}
