//
//  PhotosListModel.swift
//  ReviewGenericsTest
//
//  Created by user on 4/26/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

protocol PhotosListModelDelegate {
   func handleGetEventsResponse(photosInfoList: [PhotoInfo])
   func handleErrorResponse(error: Error)
}

class PhotosListModel {
    var delegate: PhotosListModelDelegate?
    
    private var photosInfoRequest: RequestHelper<PhotosInfoRequestModel, ArrayResponse<PhotoInfo>>?
    private var photosInfoRequestModel = PhotosInfoRequestModel()
    
    init(delegate: PhotosListModelDelegate?) {
        self.delegate = delegate
        setupGetEventsPart()
    }
    
    func fetchPhotos() {
        photosInfoRequest?.fetch()
    }
    
    private func setupGetEventsPart() {
        photosInfoRequest = RequestHelper(with: photosInfoRequestModel)
        photosInfoRequest?.loadingCallback = { [weak self] (response) in
            guard let responseModel = response else {
                return
            }
            guard let photosInfoList = responseModel.array else { return }
            
            self?.delegate?.handleGetEventsResponse(photosInfoList: photosInfoList)
        }
        
        photosInfoRequest?.errorCallback = { [weak self] (error) in
            guard let error = error else {
                return
            }
            self?.delegate?.handleErrorResponse(error: error)
        }
    }
}
