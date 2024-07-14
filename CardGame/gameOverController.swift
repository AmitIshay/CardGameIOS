//
//  gameOverController.swift
//  CardGame
//
//  Created by Student22 on 14/07/2024.
//
import CoreLocation
import UIKit

class gameOverController: UIViewController {
    
    @IBOutlet weak var back_button: UIButton!
    @IBOutlet weak var win_score_lbl: UILabel!
    @IBOutlet weak var win_name_lbl: UILabel!
    var winScore: Int?
    var winName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let score = winScore {
            win_score_lbl.text = "Score: \(score)" // Convert Int to String using String interpolation
        }
        if let name = winName {
            win_name_lbl.text =  " Name: \(name)"
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToStart", sender: self)
    }
}
