//
//  DateFunctions.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

func getStringFromDate(foodDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.medium
    formatter.timeStyle = DateFormatter.Style.none
    formatter.dateFormat = "dd.MM.yyyy"
    formatter.timeZone = TimeZone(identifier: "GMT")
    
    let stringFromDate = formatter.string(from: foodDate)
    
    return stringFromDate
}
