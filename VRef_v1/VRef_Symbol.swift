//
//  VRef_Symbols.swift
//  VRef_v1
//
//  Created by William on 08/12/2022.
//

import Foundation
import SwiftUI

struct VRef_Symbols{
    
    static let symbols = ["fb_quick" : "ellipsis.bubble.fill",
                          
                          "fb_auto" : "chart.bar.doc.horizontal.fill",
                          "fb_auto_altitude" : "airplane.departure",
                          "fb_auto_shock_level" : "poweroutlet.type.h.fill",
                          
                          "fb_manual" : "text.bubble.fill",
                          "fb_manual_[thumb_up]" : "hand.thumbsup.fill",
                          "fb_manual_[thumb_down]" : "hand.thumbsdown.fill",
                          "fb_manual_[star]" : "star.fill",
                          "fb_manual_[airplane]" : "airplane",
                          "fb_manual_[award]" : "rosette",
                          "fb_manual_[alert]" : "bell.fill",
                          "fb_manual_[time]" : "clock.fill",
                          "fb_manual_[positive_weather]" : "checkmark.icloud.fill",
                          "fb_manual_[negative_weather]" : "xmark.icloud.fill",
                          "fb_manual_[compass]" : "safari.fill",
                          "fb_manual_[emoji_happy]" : "face.smile",
                          "fb_manual_[emoji_sad]" : "face.frown",
                          "fb_manual_[mistake]" : "exclamationmark.octagon.fill",
                          "fb_manual_[eye]" : "eye.fill",
                          "fb_manual_[heart]" : "heart.fill"]
    
    public static func symbolColor(symbol: String) -> Color{
        let neutralColor: Color = Color(.sRGB, red: 240/255, green: 233/255, blue: 214/255)
        let goodColor: Color = Color(.sRGB, red: 88/255, green: 210/255, blue: 101/255)
        let badColor: Color = Color(.sRGB, red: 253/255, green: 77/255, blue: 77/255)
        let warningColor: Color = Color(.sRGB, red: 212/255, green: 175/255, blue: 55/255)
        
        switch symbol{
        case "fb_quick": return neutralColor
            
        case "fb_auto": return neutralColor
        case "fb_auto_altitude": return neutralColor
        case "fb_auto_shock_level": return badColor
        case "fb_manual": return neutralColor
        case "fb_manual_[thumb_up]": return goodColor
        case "fb_manual_[thumb_down]": return badColor
        case "fb_manual_[star]": return warningColor
        case "fb_manual_[airplane]": return neutralColor
        case "fb_manual_[award]": return warningColor
        case "fb_manual_[alert]": return badColor
        case "fb_manual_[time]": return neutralColor
        case "fb_manual_[positive_weather]": return goodColor
        case "fb_manual_[negative_weather]": return badColor
        case "fb_manual_[compass]": return neutralColor
        case "fb_manual_[emoji_happy]": return goodColor
        case "fb_manual_[emoji_sad]": return badColor
        case "fb_manual_[mistake]": return badColor
        case "fb_manual_[eye]": return neutralColor
        case "fb_manual_[heart]": return goodColor
        default:
            return neutralColor
        }
    }
    
}
