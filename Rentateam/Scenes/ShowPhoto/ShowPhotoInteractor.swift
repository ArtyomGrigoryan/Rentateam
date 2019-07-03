//
//  ShowPhotoInteractor.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowPhotoBusinessLogic {
    func makeRequest(request: ShowPhoto.Model.Request.RequestType)
}

protocol ShowPhotoDataStore {
    var photo: Hits? { get set }
    //var photo: Photos? { get set }
}

class ShowPhotoInteractor: ShowPhotoBusinessLogic, ShowPhotoDataStore {
    
    var photo: Hits?
    //var photo: Photos?
    var presenter: ShowPhotoPresentationLogic?
  
    func makeRequest(request: ShowPhoto.Model.Request.RequestType) {
        switch request {
        case .getPhoto:
            self.presenter?.presentData(response: .presentResponseData(photos: self.photo!))
        }
    }
  
}
