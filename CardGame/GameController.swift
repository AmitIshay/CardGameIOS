import UIKit

class GameController: UIViewController {
    @IBOutlet weak var lbl_locc: UILabel!
    var location = "0.0"
    var locValue: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_locc.text = locValue
    }
}
