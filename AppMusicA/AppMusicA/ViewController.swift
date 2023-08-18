import UIKit

final class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setNeedsStatusBarAppearanceUpdate()
        }

    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
            return .slide
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
    }


}

