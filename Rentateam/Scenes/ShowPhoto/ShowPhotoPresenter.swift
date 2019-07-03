//
//  ShowPhotoPresenter.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowPhotoPresentationLogic {
    func presentData(response: ShowPhoto.Model.Response.ResponseType)
}

class ShowPhotoPresenter: ShowPhotoPresentationLogic {
    
    weak var viewController: ShowPhotoDisplayLogic?
  
    func presentData(response: ShowPhoto.Model.Response.ResponseType) {
        switch response {
        case .presentResponseData(let photo):
            viewController?.displayData(viewModel: .displayPhoto(photoImage: photo.previewURL))
        }
    }
  
}
