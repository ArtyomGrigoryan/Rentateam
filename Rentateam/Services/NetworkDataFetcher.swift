//
//  NetworkDataFetcher.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getPhotos(completion: @escaping (ServerResponse?, Error?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getPhotos(completion: @escaping (ServerResponse?, Error?) -> Void) {
        networking.request() { (json, error) in
            if let error = error {
                completion(nil, error)
            } else if let json = json {
                let data = try? JSONSerialization.data(withJSONObject: json as Any)
                let decoded = self.decodeJSON(type: ServerResponse.self, from: data)
                completion(decoded, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
        
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
