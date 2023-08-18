import Foundation

// Weather Manager Structure, handels all the weather data
struct WeatherManager {
    let apiKey = "" // Enter API Key here
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid="
    
    func fetchWeather(cityName: String) {
        // Function to get the weather data from the given city name
        let urlString = "\(weatherUrl)\(apiKey)&units=metric&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
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
            // Starts the task (actually resmes it)
            task.resume()
            
        }
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?)  {
        if error != nil { // If we have an error
            print(error!)
            return
        }
        
        // When we do not have an error we save it as safeData
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8) // Convert the data into a string
            print(dataString!)
        }
        
        
    }
    
}
