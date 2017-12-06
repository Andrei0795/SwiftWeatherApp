# SwiftWeatherApp


This is an app that uses Alamofire (JSON and Networking Library) to display the weather for a specific city.

The API I used for weather is the Open Weather MAP API. The key for the API can be found in the project but please bear in mind you need to get your own key if you don't want to have problems. For more info go to https://home.openweathermap.org/.

Credits for some icons go to icons8.com.

## Screens

![alt text](https://raw.githubusercontent.com/Andrei0795/SwiftWeatherApp/master/screen1.png)
![alt text](https://raw.githubusercontent.com/Andrei0795/SwiftWeatherApp/master/screen2.png)
![alt text](https://raw.githubusercontent.com/Andrei0795/SwiftWeatherApp/master/screen3.png)



## ToDo & Bugs

Looks like Tokyo isn't working and crashes the app. It has to do with the received json file.
How the app works, at the current state you can enter just single word cities. If you enter a second word, the app will take it as a country. Example: Manchester UK.
Comas don't work in the search.
Some cities like Manchester have an US equivalent and Open Weather Map will pick the US first. That's why you can write Manchester UK in the search.


