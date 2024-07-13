import UIKit

class GameController: UIViewController {
    @IBOutlet weak var lbl_locc: UILabel!
    var location = 34.817549168324334
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
    let cards = [#imageLiteral(resourceName: "1_of_clubs.png") , #imageLiteral(resourceName: "1_of_diamonds.png") , #imageLiteral(resourceName: "1_of_hearts.png") , #imageLiteral(resourceName: "1_of_spades.png") , #imageLiteral(resourceName: "2_of_clubs.png") , #imageLiteral(resourceName: "2_of_diamonds.png") , #imageLiteral(resourceName: "2_of_hearts.png") , #imageLiteral(resourceName: "2_of_spades.png") , #imageLiteral(resourceName: "3_of_clubs.png") , #imageLiteral(resourceName: "3_of_diamonds.png") , #imageLiteral(resourceName: "3_of_hearts.png") , #imageLiteral(resourceName: "3_of_spades.png") , #imageLiteral(resourceName: "4_of_clubs.png") , #imageLiteral(resourceName: "4_of_diamonds.png") , #imageLiteral(resourceName: "4_of_hearts.png") ,
                 #imageLiteral(resourceName: "4_of_spades.png") , #imageLiteral(resourceName: "5_of_clubs.png") , #imageLiteral(resourceName: "5_of_diamonds.png") , #imageLiteral(resourceName: "5_of_hearts.png") , #imageLiteral(resourceName: "5_of_spades.png") , #imageLiteral(resourceName: "6_of_clubs.png") , #imageLiteral(resourceName: "6_of_diamonds.png") , #imageLiteral(resourceName: "6_of_hearts.png") , #imageLiteral(resourceName: "6_of_spades.png") , #imageLiteral(resourceName: "7_of_clubs.png") , #imageLiteral(resourceName: "7_of_diamonds.png") , #imageLiteral(resourceName: "7_of_hearts.png") , #imageLiteral(resourceName: "7_of_spades.png") , #imageLiteral(resourceName: "8_of_clubs.png") , #imageLiteral(resourceName: "8_of_diamonds.png") ,
                 #imageLiteral(resourceName: "8_of_hearts.png") , #imageLiteral(resourceName: "8_of_spades.png") , #imageLiteral(resourceName: "9_of_clubs.png") , #imageLiteral(resourceName: "9_of_diamonds.png") , #imageLiteral(resourceName: "9_of_hearts.png") , #imageLiteral(resourceName: "9_of_spades.png") , #imageLiteral(resourceName: "10_of_clubs.png") , #imageLiteral(resourceName: "10_of_diamonds.png") , #imageLiteral(resourceName: "10_of_hearts.png") , #imageLiteral(resourceName: "10_of_spades.png") , #imageLiteral(resourceName: "11_of_clubs.png") , #imageLiteral(resourceName: "11_of_diamonds.png") , #imageLiteral(resourceName: "11_of_hearts.png") , #imageLiteral(resourceName: "11_of_spades.png") , #imageLiteral(resourceName: "12_of_clubs.png") ,
                 #imageLiteral(resourceName: "12_of_diamonds.png") , #imageLiteral(resourceName: "12_of_hearts.png") , #imageLiteral(resourceName: "12_of_spades.png") , #imageLiteral(resourceName: "13_of_clubs.png") , #imageLiteral(resourceName: "13_of_diamonds.png") , #imageLiteral(resourceName: "13_of_hearts.png") , #imageLiteral(resourceName: "13_of_spades.png")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImages()
        if let locString = locValue, let locDouble = Double(locString) {
            if locDouble < location {
                lbl_locc.text = locValue
                right_lbl.text = nameValue
                left_lbl.text = "PC"
            } else {
                lbl_locc.text = locValue
                left_lbl.text = nameValue
                right_lbl.text = "PC"
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
        updateImages()

    }
    @objc func updateImages() {
        let randomIndex = Int.random(in: 0..<cards.count)
        left_img.image = cards[randomIndex]
        var rightIndex = Int.random(in: 0..<cards.count)
        right_img.image = cards[rightIndex]
        
               // Compare indices and update labels
               if randomIndex > rightIndex {
                   leftScore += 1
                   left_lbl.text = "\(leftScore) point"
                   right_lbl.text = "\(rightScore) point"
               } else if rightIndex > randomIndex {
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
}
