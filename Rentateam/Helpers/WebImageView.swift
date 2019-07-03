//
//  WebImageView.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageURL: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: imageURL) else { return completion(nil) }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let self = self, let data = data {
                    let name = url.lastPathComponent
                    
                    //поищем такой файл в хранилище
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                    let url1 = NSURL(fileURLWithPath: path)
                        
                    if let pathComponent = url1.appendingPathComponent(name) {
                        let fileManager = FileManager.default
                        let filePath = pathComponent.path
                        
                        if !fileManager.fileExists(atPath: filePath) {
                            //сохраним изображение в файловом менеджере
                            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                else { return }
                            
                            do {
                                try data.write(to: directory.appendingPathComponent(name))
                                print("Saved successful")
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    self.image = UIImage(data: data)
                    
                    if let httpResponse = response as? HTTPURLResponse, let date = httpResponse.allHeaderFields["Date"] as? String {
                        print("AAAAAAAAAA")
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE, dd LLL yyyy HH:mm:ss zzz"
                        let serverDate = dateFormatter.date(from: date)
                        
                        dateFormatter.locale = Locale(identifier: "ru_RU")
                        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
                        let stringDate = dateFormatter.string(from: serverDate!)
                        
                        print(stringDate)
                        
                        completion(stringDate)
                    } else {
                        print("BBBBBBBB")
                        //тут буем дергать из нашего файлового менеджера
                        if let pathComponent = url1.appendingPathComponent(name) {
                            let fileManager = FileManager.default
                            let filePath = pathComponent.path
                            
                            if fileManager.fileExists(atPath: filePath) {
                                print("Nashli")
                                
                                let attrFile: Dictionary? = try? fileManager.attributesOfItem(atPath: filePath)
                                let createdAt = attrFile![FileAttributeKey.creationDate] as! Date
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "ru_RU")
                                dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
                                let stringDate2 = dateFormatter.string(from: createdAt)
                                
                                print(stringDate2)
                                
                                completion(stringDate2)
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
