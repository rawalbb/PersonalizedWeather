//
//  WeatherManager.swift
//  PersonalizedWeather
//
//  Created by Bansri Rawal on 10/26/20.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager{
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    var delegate: WeatherManagerDelegate?
   
    
    func fetchWeather(cityName: String){
        let url = "\(baseURL)&q=\(cityName)&appid=d2674a891d8650ba5beaf6e506883261"
        performRequest(urlString: url)
    }
    
    func fetchWeather(latitude: Double, longitude: Double){
        let url = "\(baseURL)&lat=\(latitude)&lon=\(longitude)&appid=d2674a891d8650ba5beaf6e506883261"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        if let urlStr = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlStr) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let weatherdata = data{
                    if let weatherModelEntry = self.parseJson(data: weatherdata){
                        self.delegate?.didUpdateWeather(weather: weatherModelEntry)
                    }
                    
                }
            }
            task.resume()
        }
        else{
            print("Error in perform request")
        }
    }
    
    func parseJson(data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedWeather = try decoder.decode(WeatherData.self, from: data)
            let weatherMEntry = WeatherModel(location: decodedWeather.name, temp: decodedWeather.main.temp, temp_detail_num: decodedWeather.weather[0].id)
            print(decodedWeather.weather[0].id)
            print(decodedWeather.name)
            return weatherMEntry
        }
        catch
        {
            print(error)
            return nil
        }
    }
}

