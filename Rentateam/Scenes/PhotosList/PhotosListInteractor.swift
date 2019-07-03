//
//  PhotosListInteractor.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol PhotosListBusinessLogic {
    func makeRequest(request: PhotosList.Model.Request.RequestType)
}

protocol PhotosListDataStore {
    var photos: [Hits]? { get }
}

class PhotosListInteractor: PhotosListBusinessLogic, PhotosListDataStore {

    var photos: [Hits]?
    var presenter: PhotosListPresentationLogic?
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: PhotosList.Model.Request.RequestType) {
        switch request {
        case .getPhotos:
            fetcher.getPhotos { [weak self] (response, error) in
                if let photos = response?.hits, let self = self {
                    self.photos = photos
                    self.presenter?.presentData(response: .presentResponseData(photos: self.photos!))
                } else if let error = error {
                    self?.presenter?.presentData(response: .presentError(error: error.localizedDescription))
                } else {
                    self?.photos = SavedImages.getAll()
                    self?.presenter?.presentData(response: .presentResponseData(photos: self!.photos!))
                }
            }
        }
    }
}
