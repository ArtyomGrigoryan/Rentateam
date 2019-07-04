//
//  PhotosListRouter.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

@objc protocol PhotosListRoutingLogic {
    func routeToShowPhoto(segue: UIStoryboardSegue)
}

protocol PhotosListDataPassing {
    var dataStore: PhotosListDataStore? { get }
}

class PhotosListRouter: NSObject, PhotosListRoutingLogic, PhotosListDataPassing {
    
    // MARK: - Public variables
    
    var dataStore: PhotosListDataStore?
    weak var viewController: PhotosListViewController?
  
    // MARK: - Routing
  
    func routeToShowPhoto(segue: UIStoryboardSegue) {
        let dvc = segue.destination as! ShowPhotoViewController
        var destinationDS = dvc.router!.dataStore!
        passDataToShowPhoto(source: dataStore!, destination: &destinationDS)
    }
    
    func passDataToShowPhoto(source: PhotosListDataStore, destination: inout ShowPhotoDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.photo = source.photos![selectedRow!]
    }
}
