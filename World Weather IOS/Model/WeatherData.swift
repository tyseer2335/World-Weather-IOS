import Foundation

//MARK: - WeatherData Struct Decodable
struct WeatherData:Decodable {
    // Structure to modle the Weather Data that is recieved from the API
    // We decode the JSON into a Swift Stucture
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}


