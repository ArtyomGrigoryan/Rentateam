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

struct Photos {
    let hits: Hits
    let date: String
}

class PhotosListInteractor: PhotosListBusinessLogic, PhotosListDataStore {

    var photos: [Hits]?
    var photos2: [Photos]?
    var presenter: PhotosListPresentationLogic?
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: PhotosList.Model.Request.RequestType) {
        switch request {
        case .getPhotos:
            fetcher.getPhotos { [weak self] (response, error) in
                if let photos = response?.hits, let self = self {
                    self.photos = photos
                    
                    for hit in photos {
                        //print(getStringFromDate(foodDate: Date()))
                        self.photos2?.append(Photos(hits: hit, date: getStringFromDate(foodDate: Date())))
                    }
                    
                    print("connection is available")
                    self.presenter?.presentData(response: .presentResponseData(photos: photos))
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
