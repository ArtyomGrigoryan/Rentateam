//
//  DateFunctions.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

func getStringFromDate(downloadDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.medium
    formatter.timeStyle = DateFormatter.Style.none
    formatter.dateFormat = "dd.MM.yyyy"
    formatter.timeZone = TimeZone(identifier: "GMT")
    
    let stringFromDate = formatter.string(from: downloadDate)
    
    return stringFromDate
}

func getDateFromString(date: String) -> Date {
    //print("in func \(date)")
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.medium
    formatter.timeStyle = DateFormatter.Style.none
    formatter.dateFormat = "dd.MM.yyyy"
    formatter.timeZone = TimeZone(identifier: "GMT")
    
    let dateFromString = formatter.date(from: date)!
    
    return dateFromString
}
