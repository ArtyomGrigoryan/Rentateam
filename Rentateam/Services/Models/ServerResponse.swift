//
//  ServerResponse.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

struct ServerResponse: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Hits]
}

struct Hits: Decodable  {
    let previewWidth: Int
    let previewHeight: Int
    let previewURL: String
}
