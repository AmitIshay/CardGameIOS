//
//  SecondViewController.swift
//  CardGame
//
//  Created by Student22 on 10/07/2024.
//

import UIKit

class SecondViewController: UIViewController {
    var location = "0.0"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let label = UILabel()
        label.text = location
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        view.addSubview(label)
        
    }
}
