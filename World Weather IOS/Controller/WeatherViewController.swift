import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate { //🟥

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self //🟥
        // Set the weatherManager as the delagate
        searchTextField.delegate = self // Set the text field as the delagate
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        // What to do when search button is pressed
        searchTextField.endEditing(true) // Force close keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // What to do when te return button is pressed, return true or false to process return
        
        searchTextField.endEditing(true) // Force close keyboard
        print(searchTextField.text!)
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
        
        
        // We can also do some dummy proofing on when the user enters random text that is not a city name here ....
        
        if let city = searchTextField.text { // Optionally unwrap
            weatherManager.fetchWeather(cityName: city) // Call function from WeatherManager object
        }
        searchTextField.text = "" // Clears the text field when we press go
    }
    
    func didUpdateWeather(weatherObject: WeatherModel) { //🟥
        DispatchQueue.main.async { // We have to use DispatchQueue here
            
            // Set the image and temperature from the data
            self.temperatureLabel.text = weatherObject.temperatureString
            self.conditionImageView.image = UIImage(systemName: weatherObject.conditonName)
            self.cityLabel.text = weatherObject.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    

}

