//
//  PhotosListPresenter.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol PhotosListPresentationLogic {
    func presentData(response: PhotosList.Model.Response.ResponseType)
}

class PhotosListPresenter: PhotosListPresentationLogic {
    
    weak var viewController: PhotosListDisplayLogic?
  
    func presentData(response: PhotosList.Model.Response.ResponseType) {
        switch response {
        case .presentResponseData(let photos):
            let cells = photos.map { (photo)  in
                cellViewModel(from: photo)
            }
            
            let photosViewModel = PhotosViewModel(cells: cells)
            
            viewController?.displayData(viewModel: .displayPhotos(photosViewModel: photosViewModel))
        case .presentError(let error):
            viewController?.displayData(viewModel: .displayError(error: error.localizedDescription))
        }
    }
  
    private func cellViewModel(from photo: Hits) -> PhotosViewModel.Cell {
        let previewURL = photo.previewURL
        let likesCount = String(describing: photo.likes)
        let previewWidth = String(describing: photo.previewWidth)
        let previewHeight = String(describing: photo.previewHeight)
        
        return PhotosViewModel.Cell(previewURL: previewURL,
                                    likesCount: likesCount,
                                    previewImageViewWidth: previewWidth,
                                    previewImageViewHeight: previewHeight)
    }
}
