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

class ShowPhotoInteractor: ShowPhotoBusinessLogic {

    var presenter: ShowPhotoPresentationLogic?
  
    func makeRequest(request: ShowPhoto.Model.Request.RequestType) {

    }
  
}
