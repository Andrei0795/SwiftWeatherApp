//
//  WeatherObject.swift
//  SwiftWeatherApp
//
//  Created by Andrei Ionescu on 06/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import Foundation
import UIKit

class WeatherObject: NSObject {
    
    var temperature: Double
    var status: String
    var image: UIImage
    var humidity: Double
    var pressure: Double
    var wind: Double
    var name: String

    init?(json: [String: Any]) {
        guard
            let weatherArray = json["weather"] as? [AnyObject],
            let weatherJson = weatherArray.first as? [String: Any],
            let status = weatherJson["description"] as? String,
            let imageName = weatherJson["icon"] as? String,
            let mainJson = json["main"] as? [String: Any],
            let humidity = mainJson["humidity"] as? Double,
            let pressure = mainJson["pressure"] as? Double,
            let temperature = mainJson["temp"] as? Double,
            let windJson = json["wind"] as? [String: Any],
            let windSpeed = windJson["speed"] as? Double,
            let cityName = json["name"] as? String,
            let sysJson = json["sys"] as? [String: Any],
            let countryInitials = sysJson["country"] as? String
            else {
                return nil
        }
        
        self.name = cityName + ", " + countryInitials
        self.temperature = temperature
        self.humidity = humidity
        self.status = status
        self.pressure = pressure
        self.wind = windSpeed
        
        let url = URL(string: String.init(format: "http://openweathermap.org/img/w/%@.png", imageName))
        let data = try? Data(contentsOf: url!)
        self.image = UIImage.init(data: data!)!

    }
    
    func getDescription() -> String {
        
        return String.init(format: " Temperature: %@ \t Humidity: %f \t Status: %f \t Pressure: %f \t Wind: %f", self.temperature, self.humidity, self.status, self.pressure, self.wind)
    }
    
}
