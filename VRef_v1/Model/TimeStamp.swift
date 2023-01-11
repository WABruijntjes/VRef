//
//  TimeStamp.swift
//  VRef_v1
//
//  Created by William on 07/12/2022.
//

import Foundation

struct TimeStamp: Codable{
    
    let hours, minutes, seconds, miliseconds: Int
    
    var timeHoursMinutesSeconds: String {
        return "\(String(format: "%02d",hours)):\(String(format: "%02d",minutes)):\(String(format: "%02d",seconds))"
    }
    
    var timeHoursMinutes: String {
        return "\(String(format: "%02d",hours)):\(String(format: "%02d",minutes))"
    }
}
