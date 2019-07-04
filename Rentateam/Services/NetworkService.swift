//
//  NetworkService.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Alamofire
import Foundation

protocol Networking {
    func request(completion: @escaping ([String : Any]?, Error?) -> Void)
}

/*
 * Alamofire был выбран из-за того, что код для работы с сетью уже был реализован мною в другом проекте (с использованием Alamofire),
 * и из-за ограниченного времени на выполнение тестового задания мною было принято решение просто скопировать код для экономии времени
 */

class NetworkService: Networking {
    func request(completion: @escaping ([String : Any]?, Error?) -> Void) {
        if Connectivity.isConnectedToInternet {
            guard let url = URL(string: API.host + API.key) else { return }
            let queue = DispatchQueue(label: "Rentateam", qos: .background, attributes: .concurrent)
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .httpBody), headers: nil).responseJSON(queue: queue) { (response) in
                switch response.result {
                case .success(let value):
                    let json = value as! [String: Any]
                    completion(json, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else {
            //если интернет-соединение отсутствует
            completion(nil, nil)
        }
    }
}
