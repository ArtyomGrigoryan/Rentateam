//
//  PhotosListModels.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum PhotosList {
    enum Model {
        struct Request {
            enum RequestType {
                case getPhotos
            }
        }
    
        struct Response {
            enum ResponseType {
                case presentError(error: Error)
                case presentResponseData(photos: [Hits])
            }
        }
    
        struct ViewModel {
            enum ViewModelData {
                case displayError(error: String)
                case displayPhotos(photosViewModel: PhotosViewModel)
            }
        }
    }
}

struct PhotosViewModel {
    struct Cell: PhotosListCellViewModel {
        var previewURL: String
        var previewImageViewWidth: String?
        var previewImageViewHeight: String?
    }
    
    let cells: [Cell]
}
