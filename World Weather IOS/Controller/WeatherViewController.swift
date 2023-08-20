import UIKit
import CoreLocation

//MARK: - WeatherViewController Class
class WeatherViewController: UIViewController { //🟥
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backgoundImage: UIImageView!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request location access
        locationManager.delegate = self // This needs to be set before or it wont work
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Delegates
        weatherManager.delegate = self //🟥 Set the weatherManager as the delagate
        searchTextField.delegate = self // Set the text field as the delagate
        
        
    }
    
    @IBAction func LocationButtonPressed(_ sender: UIButton) {
        // Update Location when button is pressed
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    // All the logic related to the UITextField is in this extention
    @IBAction func searchPressed(_ sender: UIButton) {
        // What to do when search button is pressed
        searchTextField.endEditing(true) // Force close keyboard
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // What to do when te return button is pressed, return true or false to process return
        searchTextField.endEditing(true) // Force close keyboard
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // When the user tried to deselect the text field, we can use this to make sure that the user did not enter an empty string
        if searchTextField.text == "" {
            textField.placeholder = "Type Something" // Tells user to type something
            return false
        } else {
            return true
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // When the user stops editing in the text field, before we reset the text field we use the user input to get the weather
        
        
        if let city = searchTextField.text { // Optionally unwrap
            weatherManager.fetchWeather(cityName: city) // Call function from WeatherManager object
        }
        searchTextField.text = "" // Clears the text field when we press go
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    // All the logic related to the WeatherManager is in this extention
    func didUpdateWeather(weatherObject: WeatherModel) { //🟥
        DispatchQueue.main.async { // We have to use DispatchQueue here
            self.setEverything(weatherObject: weatherObject)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func setEverything(weatherObject: WeatherModel) {
        // Set everything from weather data
        self.temperatureLabel.text = weatherObject.temperatureString
        self.conditionImageView.image = UIImage(systemName: weatherObject.conditonName)
        self.cityLabel.text = weatherObject.cityName
        self.backgoundImage.image = weatherObject.imageName
        self.feelsLikeTemp.text = "\(weatherObject.highTemperatureString)°/ \(weatherObject.lowTemperatureString)° Feels like \(weatherObject.feelsLikeTemperatureString)°"
        self.windSpeed.text = "Wind Speed: \(weatherObject.speed) m/s"
        self.pressureLabel.text = "Pressure: \(weatherObject.pressure) hPa"
        self.humidLabel.text = "Humdity: \(weatherObject.humdity)%"
        self.descriptionLabel.text = "\(weatherObject.description)"
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

