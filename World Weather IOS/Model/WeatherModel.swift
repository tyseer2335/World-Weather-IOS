import Foundation

//MARK: - WeatherModel Struct
struct WeatherModel {
    //MARK: - Stored Properties
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    //MARK: - Computed properties
    var temperatureString: String {
        return String(format: "%.1f", temperature)
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
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }

}


