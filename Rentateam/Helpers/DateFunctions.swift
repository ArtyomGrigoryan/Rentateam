//
//  DateFunctions.swift
//  Rentateam
//
//  Created by Артем Григорян on 03/07/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

func getDateFromString(date: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, dd LLL yyyy HH:mm:ss zzz"
    let formattedDate = formatter.date(from: date)!
    
    return formattedDate
}

func getStringFromDate(downloadDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.dateFormat = "dd.MM.yy HH:mm:ss"
    
    let stringFromDate = formatter.string(from: downloadDate)
    
    return stringFromDate
}
