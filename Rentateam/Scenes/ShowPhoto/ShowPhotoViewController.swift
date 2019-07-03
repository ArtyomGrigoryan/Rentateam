//
//  ShowPhotoViewController.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowPhotoDisplayLogic: class {
    func displayData(viewModel: ShowPhoto.Model.ViewModel.ViewModelData)
}

class ShowPhotoViewController: UIViewController, ShowPhotoDisplayLogic {
    
    // MARK: - Public variables

    var interactor: ShowPhotoBusinessLogic?
    var router: (NSObjectProtocol & ShowPhotoRoutingLogic & ShowPhotoDataPassing)?

    // MARK: - @IBOutlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = ShowPhotoInteractor()
        let presenter             = ShowPhotoPresenter()
        let router                = ShowPhotoRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
  
    // MARK: - Routing
  

  
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.makeRequest(request: .getPhoto)
    }
  
    func displayData(viewModel: ShowPhoto.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayPhoto(let photo):
            print(photo)
            let name = photo + ".jpg"
            print(name)
            //let path = URL.u
            photoImageView.image = UIImage(named: name)
            //photoImageView.image = UIImage(contentsOfFile: photo)
            print(photoImageView.image)
        }
    }
  
}
