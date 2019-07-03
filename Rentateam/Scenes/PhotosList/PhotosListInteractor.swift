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

class PhotosListInteractor: PhotosListBusinessLogic {

    var photos: [Hits]?
    var presenter: PhotosListPresentationLogic?
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: PhotosList.Model.Request.RequestType) {
        switch request {
        case .getPhotos:
            fetcher.getPhotos { [weak self] (response, error) in
                if let photos = response?.hits {
                    print("connection is available")
                    self?.presenter?.presentData(response: .presentResponseData(photos: photos))
                } else {
                    //вот тут мы будем получать картинки из файлового менеджера
                    print("no connection")
                    self?.presenter?.presentData(response: .presentResponseData(photos: SavedImages.getAll()))
                    //self?.presenter?.presentData(response: .presentError(error: error!.localizedDescription))
                }
            }
        }
    }
  
}
