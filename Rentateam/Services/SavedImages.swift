//
//  SavedImages.swift
//  Rentateam
//
//  Created by Артем Григорян on 02/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

class SavedImages {
    static func getAll() -> [Hits] {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return []
        }
        
        guard let contents = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]) else {
            return []
        }
        
        var hits: [Hits] = []
        
        for url in contents {
            hits.append(Hits(likes: 0, previewWidth: 0, previewHeight: 0, previewURL: url.absoluteString))
        }
        
        return hits
    }
}
