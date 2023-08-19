import Foundation
import CoreLocation

//MARK: - WeatherManagerDelegate Protocol
protocol WeatherManagerDelegate { // 🟥
    // Delegate protocol
    func didUpdateWeather(weatherObject: WeatherModel)
    func didFailWithError(error: Error)
    
    // Delagate Design Pattern 🟥
    // 1. In the struct create a var called delegate and set it to an optional custom data type
    // 2. Make a protocol with the same type as the optional custom data type, add the method you need
    // 3. Call the delegate by using delegate?.Myfunction
    // 4. In the other file inherit the protocol and implement the function
    // 5. Dont forget to set the struct.delegate to self in the viewDidLoad function
    
}

// Weather Manager Structure, handels all the weather data
struct WeatherManager {
    let apiKey = ""
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid="
    
    var delegate: WeatherManagerDelegate? // 🟥
    // Optional delegate structure
    // If some class or some struct sets themself as a delegate, then we can call the delegate method
    
    func fetchWeather(cityName: String) {
        // Function to get the weather data from the given city name
        let urlString = "\(weatherUrl)\(apiKey)&units=metric&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // Function to get weather data from given longatide and latitide
        // Notice that we can have functions with the same name in swift, with different paramaters
        let urlString = "\(weatherUrl)\(apiKey)&units=metric&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    
    //MARK: - Networking Code
    func performRequest(urlString: String) {
        // The function that handles networking
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            // (Creats a task that retrieves the contenst of the url, calls hander after competion returns url session data task)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //4. Start the task
            // Starts the task (actually resumes it)
            task.resume()
            
        }
        
    }
    //MARK: - handle Function
    func handle(data: Data?, response: URLResponse?, error: Error?)  {
        // Handel function that either prints error or parses JSON
        if error != nil { // If we have an error
            delegate?.didFailWithError(error: error!)
            return
        } else { // When we do not have an error we save it as safeData
            if let safeData = data {
                if let weatherObject = parseJSON(weatherData: safeData) {
                    // Optional bind the output of the weatherObject function
                    // We send it back to the weatherViewController
                    delegate?.didUpdateWeather(weatherObject: weatherObject) // 🟥
                }
            }
        }
    }
    
    //MARK: - parseJSON
    func parseJSON(weatherData: Data) -> WeatherModel? {
        // Function to parse the JSON data
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            // Take stuff from decoded data
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            // Put the data into a weather object
            let weatherObject = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            // Return the WeatherModel Object
            return weatherObject
            
        } catch {
            // Print Error
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
