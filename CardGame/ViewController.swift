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
            UserDefaults.standard.set(newName, forKey: nameKey)
            nameTextField.isHidden = true
            wel_text.text = "Hello, \(newName)!"
        }
                
                nameTextField.resignFirstResponder()    }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("got location: \(lat) \(lon)")
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
