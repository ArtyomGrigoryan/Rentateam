//
//  ShowPhotoModels.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum ShowPhoto {
    enum Model {
        struct Request {
            enum RequestType {
                case getPhoto
            }
        }
    
        struct Response {
            enum ResponseType {
                //case presentResponseData(photos: Photos)
                case presentResponseData(photos: Hits)
            }
        }
    
        struct ViewModel {
            enum ViewModelData {
                case displayPhoto(photoImage: String)
            }
        }
    }
}
