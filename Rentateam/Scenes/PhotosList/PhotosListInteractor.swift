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
                print("84378378375873847 587 8574 \(error)")
                if let photos = response?.hits {
                    self?.photos = photos
                    print("connection is available")
                    self?.presenter?.presentData(response: .presentResponseData(photos: photos))
                } else {
                    //вот тут мы будем получать картинки из файлового менеджера
                    print("no connection")
                    self?.photos = SavedImages.getAll()
                    self?.presenter?.presentData(response: .presentResponseData(photos: self!.photos!))
                    //self?.presenter?.presentData(response: .presentError(error: error!.localizedDescription))
                }
            }
        }
    }
  
}
