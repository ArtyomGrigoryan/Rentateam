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

    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.makeRequest(request: .getPhoto)
    }
  
    func displayData(viewModel: ShowPhoto.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayPhoto(let photo):
            print(photo)
            guard let url1 = URL(string: photo) else { return }
            print(url1)
            
            URLSession.shared.dataTask(with: url1) { [weak self] (data, response, error) in
                print("888888")
                DispatchQueue.main.async {
                    if let self = self, let data = data {
                        print("12121212122121")
                        self.photoImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
//            guard let url1 = URL(string: photo) else { return }
//
//            let name = url1.lastPathComponent
//            let result = name.substring(from: name.index(name.startIndex, offsetBy: 0))
//
//            //поищем такой файл в нашем менеджере
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            let url = NSURL(fileURLWithPath: path)
//
//            if let pathComponent = url.appendingPathComponent(result) {
//                let filePath = pathComponent.path
//                let fileManager = FileManager.default
//
//                if fileManager.fileExists(atPath: filePath) {
//                    photoImageView.image = UIImage(contentsOfFile: filePath)!
//                }
//            }
        }
    }
  
}
