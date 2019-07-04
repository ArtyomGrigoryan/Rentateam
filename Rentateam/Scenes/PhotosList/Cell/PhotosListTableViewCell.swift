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
    var previewImageViewWidth: String? { get }
    var previewImageViewHeight: String? { get }
}

class PhotosListTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageViewHeightLabel: UILabel!
    @IBOutlet weak var previewImageViewWidthLabel: UILabel!
    @IBOutlet weak var previewImageImageView: WebImageView!
    @IBOutlet weak var downloadDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: PhotosListCellViewModel) {
        previewImageViewWidthLabel.text = viewModel.previewImageViewWidth!
        previewImageViewHeightLabel.text = viewModel.previewImageViewHeight!
        /*
         * Не думаю, что это в лучших традициях Clean Swift.
         * Была идея создать отдельную структуру в интеракторе, в которой будет поле "Дата",
         * значения в которую будут устанавливаться с помощью Date().
         * Но тогда пришлось бы создавать новый цикл, объекты.
         * И, как мне кажется, по условию задачи ожидается получение даты из URLResponse
         */
        previewImageImageView.set(imageURL: viewModel.previewURL) { [weak self] (date) in
            self?.downloadDateLabel.text = date!
        }
    }
}
