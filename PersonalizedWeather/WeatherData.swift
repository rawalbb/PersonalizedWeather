//
//  WeatherData.swift
//  PersonalizedWeather
//
//  Created by Bansri Rawal on 10/26/20.
//

import Foundation
struct WeatherData: Codable{
    let name: String
    let weather: [Weather]
    let main: Main
    
}

struct Weather: Codable{
    let id: Int
}

struct Main: Codable{
    let temp: Double
}
