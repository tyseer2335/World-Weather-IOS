import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
        
        
        
        searchTextField.text = "" // Clears the text field when we press go
    }
    

}

