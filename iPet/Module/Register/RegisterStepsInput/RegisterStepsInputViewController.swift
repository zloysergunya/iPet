import UIKit

class RegisterStepsInputViewController: ViewController<RegisterStepsInputView> {
    
    private let provider = RegisterStepsInputProvider()
    
    private var stepsCount = 4000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.continueButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        mainView.minusButton.addTarget(self, action: #selector(changeStepsCount), for: .touchUpInside)
        mainView.plusButton.addTarget(self, action: #selector(changeStepsCount), for: .touchUpInside)
        
        mainView.stepsCountField.delegate = self
        mainView.stepsCountField.text = "\(stepsCount)"
        updateStepsCount(stepsCount)

        hideKeyboardWhenTappedAround()
        bindEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateStepsCount(_ count: Int) {
        stepsCount = count
        
        let s: Float = 80.0 // Average pitch length, cm
        let r: Float = (Float(count) * s) / 100000.0
        mainView.aboutKilometersLabel.text = "≈ \(String(format: "%.2f", r)) км"
    }
    
    private func sendMe() {
        
        guard stepsCount > 0 else {
            Animations.shake(view: mainView.stepsCountField)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        var userMe = UserMeRequest()
        userMe.stepsCount = stepsCount
        
        provider.patchUser(userMe: userMe) { [weak self] result in
            switch result {
            case .success(let user):
                UserSettings.user = user
                UserSettings.userReady = true
                self?.navigationController?.pushViewController(TabBarController(), animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    @objc private func changeStepsCount(_ sender: UIButton) {
        let count = stepsCount + sender.tag
        
        mainView.stepsCountField.delegate = self
        mainView.stepsCountField.text = "\(count)"
        updateStepsCount(count)
    }
    
    @objc private func save(_ sender: UIButton) {        
        sendMe()
    }
    
    private func bindEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard
            let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        else {
            return
        }

        let keyBoardHeight = keyboardRect.height
        
        mainView.updateButtonBottomConstraint(duration: duration, -keyBoardHeight - 12.0)
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        
        mainView.updateButtonBottomConstraint(duration: duration)
    }
    
}

// MARK: - UITextFieldDelegate
extension RegisterStepsInputViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        guard let count = Int(replacedText), replacedText.count < 7 else {
            Animations.shake(view: mainView.stepsCountField)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return false
        }
        
        updateStepsCount(count)

        return true
    }
    
}
