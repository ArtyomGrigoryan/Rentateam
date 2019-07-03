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
        //print(11)
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let self = self, let data = data {
                    let name = url.lastPathComponent
                    
                    //поищем такой файл в хранилище
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                    let url1 = NSURL(fileURLWithPath: path)
                        
                    if let pathComponent = url1.appendingPathComponent(name) {
                        let filePath = pathComponent.path
                        let fileManager = FileManager.default
                       // print(22)
                        if !fileManager.fileExists(atPath: filePath) {
                            //сохраним изображение в файловом менеджере
                            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                else { return }
                            
                            do {
                                try data.write(to: directory.appendingPathComponent(name))
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse, let date = httpResponse.allHeaderFields["Date"] as? String {
                        //print(httpResponse.allHeaderFields)
                        print(date)
                    } else {
                        //тут буем дергать из нашего файлового менеджера
                        print("ЖОПА")
                    }
                    
                    //print(response!)
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
