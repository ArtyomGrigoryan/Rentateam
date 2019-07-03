//
//  PhotosListTableViewCell.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol PhotosListCellViewModel {
    var previewURL: String { get }
    var likesCount: String? { get }
    var previewImageViewWidth: String? { get }
    var previewImageViewHeight: String? { get }
}

class PhotosListTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageViewHeightLabel: UILabel!
    @IBOutlet weak var previewImageViewWidthLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var previewImageImageView: WebImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: PhotosListCellViewModel) {
        previewImageImageView.set(imageURL: viewModel.previewURL) { [weak self] (date) in
            self?.likesCountLabel.text = date!
        }
        previewImageViewWidthLabel.text = viewModel.previewImageViewWidth!
        previewImageViewHeightLabel.text = viewModel.previewImageViewHeight!
    }
}
