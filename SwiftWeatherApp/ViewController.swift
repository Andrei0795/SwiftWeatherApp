//
//  ViewController.swift
//  SwiftWeatherApp
//
//  Created by Andrei Ionescu on 06/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var apiKey: String = "28aa35951042a5adea9c73760b1f25e8"
    var weatherObject: WeatherObject!
    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        self.weatherView.alpha = 0.0
        //self.makeRequest(cityName: "Iasi")
    }
    
    func makeRequest(cityLat: Double, cityLon: Double) {
        
        Alamofire.request(String.init(format: "http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=%@", String(cityLat), String(cityLon), apiKey)).responseJSON { response in
            
        }
    }
    
    func makeRequest(cityName: String) {
        
        Alamofire.request(String.init(format: "http://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@", String(cityName), apiKey)).responseJSON { response in
            
            
            print(response)
            //to get JSON return value
            if let result = response.result.value {
                let JSON = result as! [String:  AnyObject]
                self.weatherObject = WeatherObject.init(json: JSON)
                
                if self.weatherObject != nil {
                    print(self.weatherObject.getDescription())
                    self.temperatureLabel.text = String.init(format: "%.2f", self.weatherObject.temperature - 273.15) + "º"
                    self.statusLabel.text = self.weatherObject.status
                    self.pressureLabel.text = String(describing: self.weatherObject.pressure) + "hpa"
                    self.humidityLabel.text = String(describing: self.weatherObject.humidity) + "%"
                    self.windSpeedLabel.text = String(describing: self.weatherObject.wind) + "m/s"
                    self.statusImage.image = self.weatherObject.image
                    self.nameLabel.text = self.weatherObject.name
                    
                    self.errorView.alpha = 0.0
                    self.weatherView.alpha = 1.0
                } else {
                    self.changeAndDisplayErrorLabel(text: JSON["message"] as! String)
                }
            }

        }
        
    }
    
    func changeAndDisplayErrorLabel(text: String) {
        self.errorLabel.text = text
        self.errorView.alpha = 1.0
        self.weatherView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        
        if let city = textField.text {
            
            let cityAndCountryArray = city.components(separatedBy: " ")
            
            if cityAndCountryArray.count == 1 {
                self.makeRequest(cityName: cityAndCountryArray[0])
            } else {
                if cityAndCountryArray[1].trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    self.makeRequest(cityName: cityAndCountryArray[0] + "," + cityAndCountryArray[1])
                } else {
                    self.makeRequest(cityName: cityAndCountryArray[0])
                }
            }
        }
        
        textField.resignFirstResponder()
        return false
    }
}

