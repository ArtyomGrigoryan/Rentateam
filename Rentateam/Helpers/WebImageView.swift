//
//  WebImageView.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    //completion вернет дату загрузки изображения в строковом формате
    func set(imageURL: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: imageURL) else { return completion(nil) }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let self = self {
                    print("url \(url)")
                    //вырежем из url всё, что находится до названия файла с его расширением (останется только, например, fiat-4298163_150.jpg)
                    let imageName = url.lastPathComponent
                
                    //начнем искать такой файл в файловой системе iPhone
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                    let url1 = NSURL(fileURLWithPath: path)
                    print("url1 is \(url1)")
                        
                    if let pathComponent = url1.appendingPathComponent(imageName) {
                        print("pathComponent is \(pathComponent)")
                        let fileManager = FileManager.default
                        let filePath = pathComponent.path
                        
                        //если такое изображение отсутствует в файловой системе iPhone, то
                        if !fileManager.fileExists(atPath: filePath) {
                            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                else { return }
                            
                            //попытаемся сохранить это изображение в файловой системе, чтобы потом иметь возможность получить его без интернет-соединения
                            do {
                                try data.write(to: directory.appendingPathComponent(imageName))
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    self.image = UIImage(data: data)
                    
                    //если есть подключение к интернету, то будем получать дату загрузки изображения с сервера из HTTPURLResponse
                    if let httpResponse = response as? HTTPURLResponse, let stringDate = httpResponse.allHeaderFields["Date"] as? String {
                        let formattedDate = getDateFromString(date: stringDate)
                        let formattedStringDate = getStringFromDate(downloadDate: formattedDate)
                        
                        completion(formattedStringDate)
                    } else {
                        //если подключение к интернету отсутствует, то
                        if let pathComponent = url1.appendingPathComponent(imageName) {
                            let fileManager = FileManager.default
                            let filePath = pathComponent.path
                            
                            //получим дату загрузки файла (находящегося в файловой системе) из его аттрибутов
                            if fileManager.fileExists(atPath: filePath) {
                                let attributes: Dictionary? = try? fileManager.attributesOfItem(atPath: filePath)
                                let createdAt = attributes![FileAttributeKey.creationDate] as! Date
                                let stringDate = getStringFromDate(downloadDate: createdAt)
                                
                                completion(stringDate)
                            } else {
                                completion(nil)
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}
