//
//  ViewController.swift
//  CardGame
//
//  Created by Student22 on 08/07/2024.
//
import CoreLocation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var wel_text: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    let nameKey = "savedName"
    var locationManager: CLLocationManager!
    var isLocationAvailable: Bool = false
    var sendLoc = "0.0"
    var savedName: String? // Declare savedName as a class-level variable
    var lat: CLLocationDegrees?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedName()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedName()
    }

    func loadSavedName() {
        if let savedName = UserDefaults.standard.string(forKey: nameKey) {
            self.savedName = savedName // Assign savedName to the class-level variable
            if !savedName.isEmpty {
                nameTextField.isHidden = true
                wel_text.text = "Hello, \(savedName)!"
            } else {
                nameTextField.isHidden = false
                wel_text.text = "Enter your name"
            }
        } else {
            nameTextField.isHidden = false
            wel_text.text = "Enter your name"
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        locationManager.requestLocation()
        if let newName = nameTextField.text, !newName.isEmpty {
            if let lat = self.lat {
                sendLoc = "\(lat)"
                // Both name and location are available, proceed to the next activity
                UserDefaults.standard.set(newName, forKey: nameKey)
                nameTextField.isHidden = true
                wel_text.text = "Hello, \(newName)!"
                self.performSegue(withIdentifier: "goToResult", sender: self)
            } else {
                // Location is not available yet
                print("Location is not available yet. Please wait.")
            }
        } else {
            // Name is empty
            print("Name cannot be empty.")
        }
        
        nameTextField.resignFirstResponder()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destVC = segue.destination as! GameController
            destVC.locValue = sendLoc
            destVC.nameValue = savedName
        }
     }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                isLocationAvailable = true
                locationManager.stopUpdatingLocation()
                self.lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                print("got location: \(self.lat!) \(lon)")
                sendLoc = "\(lat ?? 0.0)" // Convert to String
            }
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Failed to get location:", error.localizedDescription)
       }

       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse {
               // Permission granted, request location update
               locationManager.requestLocation()
           } else {
               // Handle denial of permission
               print("Location permission denied")
           }
       }}
