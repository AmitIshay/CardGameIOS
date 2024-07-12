import UIKit

class GameController: UIViewController {
    @IBOutlet weak var lbl_locc: UILabel!
    var location = 34.817549168324334
    @IBOutlet weak var timer_lbl: UILabel!
    @IBOutlet weak var left_lbl: UILabel!
    var locValue: String?
    var nameValue: String?
    var countdownTimer: Timer?
    var totalTime = 5 // Total time for the countdown
    @IBOutlet weak var right_lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
