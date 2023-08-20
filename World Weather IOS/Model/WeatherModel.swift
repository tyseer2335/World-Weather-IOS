import Foundation
import UIKit

//MARK: - WeatherModel Struct
struct WeatherModel {
    //MARK: - Stored Properties
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let high: Double
    let low: Double
    let feelsLike: Double
    let pressure: Int
    let humdity: Int
    let description: String
    let speed: Double
    
    
    //MARK: - Computed properties
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var highTemperatureString: String {
        return String(format: "%.1f", high)
    }
    
    var lowTemperatureString: String {
        return String(format: "%.1f", low)
    }
    
    var feelsLikeTemperatureString: String {
        return String(format: "%.1f", feelsLike)
    }
    
    var conditonName: String  {
        // Computed property to handle the image names to display the image depending on the current weather
        switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud"
                default:
                    return "cloud"
                }
    }
    
    var imageName: UIImage {
        // Computed property to handle the image backgrounds to display the image depending on the current weather
        switch conditionId {
                case 200...232:
            return UIImage(named: "bolt.jpg")!
                case 300...321:
            return UIImage(named: "drizzle.jpg")!
                case 500...531:
            return UIImage(named: "rain.jpg")!
                case 600...622:
            return UIImage(named: "snow.jpg")!
                case 701...781:
            return UIImage(named: "fog.jpg")!
                case 800:
            return UIImage(named: "sun.jpg")!
                case 801...804:
            return UIImage(named: "cloud.jpg")!
                default:
            return UIImage(named: "cloud.jpg")!
                }
    }

}




