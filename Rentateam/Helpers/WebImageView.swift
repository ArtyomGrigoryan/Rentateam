//
//  WebImageView.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    /*
     * completion вернет дату загрузки изображения в строковом формате
     */
    func set(imageURL: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: imageURL) else { return completion(nil) }
        
        /*
         * в константе filePath будет сохранен только путь до изображения. Если речь идет о сетевом адресе, то название хоста будет вырезано,
         * останется только, например, /photo/2019/07/01/18/16/water-lily-4310596_150.jpg. А если изображение сохранено в файловой системе,
         * то из url будет вырезан фрагмент "file://"
         */
        let filePath = url.path
        //вырежем из url всё, что находится до названия файла с его расширением (останется только, например, fiat-4298163_150.jpg)
        let imageName = url.lastPathComponent
        //файловый менеджер предоставит доступ к файловой системе iPhone
        let fileManager = FileManager.default
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let self = self {
                    //если такое изображение отсутствует в файловой системе iPhone, то
                    if !fileManager.fileExists(atPath: filePath) {
                        
                        //получим полный путь до директории на iPhone, в котором хранятся скачанные изображения
                        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                            else { return }

                        //попытаемся сохранить это изображение в файловой системе, чтобы потом иметь возможность получить его без интернет-соединения
                        do {
                            try data.write(to: directory.appendingPathComponent(imageName))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                    //установим изображение в imageView
                    self.image = UIImage(data: data)
                    
                    //если есть подключение к интернету, то будем получать дату загрузки изображения с сервера из HTTPURLResponse
                    if let httpURLResponse = response as? HTTPURLResponse, let stringDate = httpURLResponse.allHeaderFields["Date"] as? String {
                        //перегоним дату из строки в Date, чтобы потом смочь форматировать дату в любой вид
                        let formattedDate = getDateFromString(date: stringDate)
                        //получим дату в строковом формате в уже нужном нам виде (dd.MM.yy HH:mm:ss)
                        let formattedStringDate = getStringFromDate(downloadDate: formattedDate)
                        //вернем дату
                        completion(formattedStringDate)
                    } else {
                        //если подключение к интернету отсутствует, то получим дату загрузки файла (находящегося в файловой системе) из его аттрибутов
                        if fileManager.fileExists(atPath: filePath) {
                            //получим все аттрибуты
                            let attributes: Dictionary? = try? fileManager.attributesOfItem(atPath: filePath)
                            //нам нужен аттрибует "Дата создания (creationDate)"
                            let createdAt = attributes![FileAttributeKey.creationDate] as! Date
                            //отформатируем дату
                            let stringDate = getStringFromDate(downloadDate: createdAt)
                            //вернем дату
                            completion(stringDate)
                        } else {
                            //вернем nil
                            completion(nil)
                        }
                    }
                }
            }
        }.resume()
    }
}
