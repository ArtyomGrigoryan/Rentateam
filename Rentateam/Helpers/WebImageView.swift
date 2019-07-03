//
//  WebImageView.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        //реализуем функционал загрузки изображения из интернета
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let self = self, let data = data {
                    self.image = UIImage(data: data)

                    let withoutExt = url.deletingPathExtension()
                    let name = withoutExt.lastPathComponent
                    let result = name.substring(from: name.index(name.startIndex, offsetBy: 0))
                
                    //поищем такой файл в нашем менеджере
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                    let url = NSURL(fileURLWithPath: path)
                    
                    if let pathComponent = url.appendingPathComponent(result) {
                        let filePath = pathComponent.path
                        let fileManager = FileManager.default
                        
                        if !fileManager.fileExists(atPath: filePath) {
                            //сохраним изображение в файловом менеджере
                            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
                            
                            do {
                                try data.write(to: directory.appendingPathComponent(result))
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
