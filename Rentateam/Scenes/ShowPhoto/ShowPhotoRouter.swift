//
//  ShowPhotoRouter.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowPhotoRoutingLogic {

}

protocol ShowPhotoDataPassing {
    var dataStore: ShowPhotoDataStore? { get }
}

class ShowPhotoRouter: NSObject, ShowPhotoRoutingLogic, ShowPhotoDataPassing {
    
    var dataStore: ShowPhotoDataStore?
    weak var viewController: ShowPhotoViewController?
  
    // MARK: - Routing
  
}
