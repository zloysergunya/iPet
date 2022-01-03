import UIKit

class LaunchViewController: ViewController<LaunchView> {

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LaunchHelper.selectViewController()
    }
    
}
