//
//  WeatherViewController.swift
//  PersonalizedWeather
//
//  Created by Bansri Rawal on 10/26/20.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        weatherManager.fetchWeather(cityName: "London")
        
        searchBar.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchBar.endEditing(true)
        if let searchEntry = searchBar.text{
        weatherManager.fetchWeather(cityName: searchEntry)
        }
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    

}

//MARK: -Search Button
extension WeatherViewController: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Tapped")
        searchBar.endEditing(true)
        if let searchEntry = searchBar.text{
        weatherManager.fetchWeather(cityName: searchEntry)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
}

//MARK: -WeatherUpdate

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async{
            self.detailImage.image = UIImage(systemName: weather.temp_detal)
            self.temperature.text = weather.temp_string
            self.cityName.text = weather.location
        }
    }
    
    
}

extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: long)
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in Location Manager", error)
    }
    }
    

