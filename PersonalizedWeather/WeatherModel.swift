//
//  WeatherModel.swift
//  PersonalizedWeather
//
//  Created by Bansri Rawal on 10/26/20.
//

import Foundation
import UIKit

struct WeatherModel{
    let location: String
    let temp: Double
    let temp_detail_num: Int
    var temp_string: String{
        return String(format: "%.1f", temp)
    }
    var temp_detal: String{
        switch temp_detail_num{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 500...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    

    
}
