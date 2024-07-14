import UIKit

class GameController: UIViewController {
    @IBOutlet weak var lbl_locc: UILabel!
    var location = 34.817549168324334
    @IBOutlet weak var right_name_lbl: UILabel!
    @IBOutlet weak var left_name_lbl: UILabel!
    @IBOutlet weak var timer_lbl: UILabel!
    @IBOutlet weak var left_lbl: UILabel!
    var locValue: String?
    var nameValue: String?
    var countdownTimer: Timer?
    var leftScore = 0
    var rightScore = 0
    @IBOutlet weak var right_img: UIImageView!
    @IBOutlet weak var left_img: UIImageView!
    var totalTime = 5 // Total time for the countdown
    
    @IBOutlet weak var right_lbl: UILabel!
    private let cards = [
        "1_of_clubs", "1_of_diamonds", "1_of_hearts", "1_of_spades",
        "2_of_clubs", "2_of_diamonds", "2_of_hearts", "2_of_spades",
        "3_of_clubs", "3_of_diamonds", "3_of_hearts", "3_of_spades",
        "4_of_clubs", "4_of_diamonds", "4_of_hearts", "4_of_spades",
        "5_of_clubs", "5_of_diamonds", "5_of_hearts", "5_of_spades",
        "6_of_clubs", "6_of_diamonds", "6_of_hearts", "6_of_spades",
        "7_of_clubs", "7_of_diamonds", "7_of_hearts", "7_of_spades",
        "8_of_clubs", "8_of_diamonds", "8_of_hearts", "8_of_spades",
        "9_of_clubs", "9_of_diamonds", "9_of_hearts", "9_of_spades",
        "10_of_clubs", "10_of_diamonds", "10_of_hearts", "10_of_spades",
        "11_of_clubs", "11_of_diamonds", "11_of_hearts", "11_of_spades",
        "12_of_clubs", "12_of_diamonds", "12_of_hearts", "12_of_spades",
        "13_of_clubs", "13_of_diamonds", "13_of_hearts", "13_of_spades",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let locString = locValue, let locDouble = Double(locString) {
            if locDouble < location {
                lbl_locc.text = locValue
                right_name_lbl.text = nameValue
                left_name_lbl.text = "PC"
            } else {
                lbl_locc.text = locValue
                left_name_lbl.text = nameValue
                right_name_lbl.text = "PC"
            }
        } else {
            // Handle the case where locValue could not be converted to a Double
            // This could happen if locValue is nil or not a valid numeric string
            lbl_locc.text = locValue
            // Decide what to do with left_lbl and right_lbl in case of error
        }
        startTimer()
    }
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        if leftScore != 10 && rightScore != 10 {
            updateImages()
        } else {
            self.performSegue(withIdentifier: "goToGameover", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameover" {
            let destVC = segue.destination as! gameOverController
            if leftScore == 10 {
                destVC.winName =  left_name_lbl.text
                destVC.winScore = leftScore
            } else {
                destVC.winName = right_name_lbl.text
                destVC.winScore = rightScore
            }

        }
     }
    
    @objc func updateImages() {
        let leftCard = drawCard()
        let rightCard = drawCard()
        left_img.image = UIImage(named: leftCard)
        right_img.image = UIImage(named: rightCard)
        let leftValue = cardValue(cardName: leftCard)
        let rightValue = cardValue(cardName: rightCard)
        
        // Compare indices and update labels
        if leftValue > rightValue {
            leftScore += 1
            left_lbl.text = "\(leftScore) point"
            right_lbl.text = "\(rightScore) point"
        } else if rightValue > leftValue {
            rightScore += 1
            left_lbl.text = "\(leftScore) point"
            right_lbl.text = "\(rightScore) point"
        }
    }
    
    @objc func updateTimer() {
        if totalTime > 0 {
            timer_lbl.text = "\(totalTime) seconds"
            totalTime -= 1
        } else {
            // Reset totalTime to initial value (5 seconds)
            totalTime = 5
            timer_lbl.text = "Restart"
            // Stop the current timer
            countdownTimer?.invalidate()
            // Start the timer again
            startTimer()
        }
    }
    
    deinit {
        // Make sure to invalidate the timer when the view controller is deallocated
        countdownTimer?.invalidate()
    }
    private func cardValue(cardName: String) -> Int {
        let components = cardName.split(separator: "_")
        return Int(components[0]) ?? 0
    }
    func drawCard() -> String {
        return cards[Int(arc4random_uniform(UInt32(cards.count - 1)))]
    }
}
