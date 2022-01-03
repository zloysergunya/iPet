import UIKit

class OnboardingViewController: ViewController<OnboardingView> {

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.continueButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func nextStep() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
}
