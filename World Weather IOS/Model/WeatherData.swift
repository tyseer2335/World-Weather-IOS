import Foundation

//MARK: - WeatherData Struct Decodable
struct WeatherData:Decodable {
    // Structure to modle the Weather Data that is recieved from the API
    // We decode the JSON into a Swift Stucture
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Wind: Decodable {
    let speed: Double
}


