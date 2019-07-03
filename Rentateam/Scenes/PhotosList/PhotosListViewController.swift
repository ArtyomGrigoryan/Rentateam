//
//  PhotosListViewController.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol PhotosListDisplayLogic: class {
    func displayData(viewModel: PhotosList.Model.ViewModel.ViewModelData)
}

class PhotosListViewController: UITableViewController, PhotosListDisplayLogic {

    // MARK: - Public variables
    
    var interactor: PhotosListBusinessLogic?
    var router: (NSObjectProtocol & PhotosListRoutingLogic)?
    
    // MARK: - Private variables
    
    private var photosViewModel = PhotosViewModel(cells: [])

    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = PhotosListInteractor()
        let presenter             = PhotosListPresenter()
        let router                = PhotosListRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
  
    // MARK: - Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.makeRequest(request: .getPhotos)
    }
  
    func displayData(viewModel: PhotosList.Model.ViewModel.ViewModelData) {
        DispatchQueue.main.async {
            switch viewModel {
            case .displayPhotos(let photosViewModel):
                self.photosViewModel = photosViewModel
                self.tableView.reloadData()
            case .displayError(let error):
                self.errorAlert(title: error)
                self.interactor?.makeRequest(request: .getPhotos)
            }
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosViewModel.cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosListTableViewCell.self), for: indexPath) as! PhotosListTableViewCell
        let cellViewModel = photosViewModel.cells[indexPath.row]
        
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
  
    // MARK: - Helpers
    
    func errorAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
}
