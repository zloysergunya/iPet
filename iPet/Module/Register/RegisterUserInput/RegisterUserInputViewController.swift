import UIKit

class RegisterUserInputViewController: ViewController<RegisterUserInputView> {
    
    private let usernameRegularExpression = "^[a-z0-9_.-]*$"
    private let provider = RegisterUserInputProvider()
    
    private var pendingCheckAvailabilityNicknameRequestWorkItem: DispatchWorkItem?
    private var pendingTranslitNameRequestWorkItem: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.continueButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        mainView.photoPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickPhoto)))
        
        mainView.nameInputView.textField.delegate = self
        mainView.usernameInputView.textField.delegate = self
        
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
    
    private func bindEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func checkAvailabilityNickname(_ username: String) {
        provider.checkAvailabilityNickname(username) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let used):
                if used, let text = self.mainView.usernameInputView.textField.text, username == text {
                    self.mainView.usernameInputView.errorLabel.text = "Никнейм уже занят"
                }
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func translitName(_ name: String) {
        provider.translitName(name) { [weak self] result in
            switch result {
            case .success(let username):
                self?.mainView.usernameInputView.textField.text = username
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    @discardableResult
    private func validateUsername(_ username: String) -> Bool {
        let minCount = 5
        let maxCount = 20
        let match = NSPredicate(format:"SELF MATCHES %@", usernameRegularExpression).evaluate(with: username)
        
        mainView.usernameInputView.errorLabel.text?.removeAll()
        
        if username.count < minCount {
            if match {
                mainView.usernameInputView.errorLabel.text = "Слишком короткий. Минимум \(minCount) символов"
            } else {
                mainView.usernameInputView.errorLabel.text = "Используй латинские буквы и цифры"
            }
        }

        if username.count > maxCount {
            mainView.usernameInputView.errorLabel.text = "Слишком длинный. Максимум \(maxCount) символов"
            
            return false
        }

        if match, username.count >= minCount, username.count <= maxCount, username != UserSettings.user?.username {
            pendingCheckAvailabilityNicknameRequestWorkItem?.cancel()

            let requestWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else {
                    return
                }

                if !username.isEmpty {
                    self.checkAvailabilityNickname(username)
                }
            }

            pendingCheckAvailabilityNicknameRequestWorkItem = requestWorkItem
            DispatchQueue.main.async(execute: requestWorkItem)
        }
        
        return match
    }
    
    private func sendMe() {
        guard mainView.usernameInputView.errorLabel.text != "Никнейм уже занят" else {
            Animations.shake(view: mainView.usernameInputView.errorLabel)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        guard let name = mainView.nameInputView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            Animations.shake(view: mainView.nameInputView)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        guard let username = mainView.usernameInputView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !username.isEmpty else {
            Animations.shake(view: mainView.usernameInputView)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        var userMe = UserMeRequest()
        userMe.name = name
        userMe.username = username
        
        provider.patchUser(userMe: userMe) { [weak self] result in
            switch result {
            case .success(let user):
                UserSettings.user = user
                self?.navigationController?.pushViewController(RegisterPickPetViewController(), animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func uploadUserPhoto() {
        guard let image = mainView.photoPlaceholderImageView.image else {
            return
        }
        
        let data = image.jpegData(compressionQuality: 0.8)
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = paths[0].appendingPathComponent("image.jpg")
        try? data?.write(to: filename)
        
        provider.uploadUserPhoto(photo: filename) { result in
            switch result {
            case .success(let url):
                UserSettings.user?.avatarURL = url
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    @objc private func save(_ sender: UIButton) {
        Animations.press(view: sender)
        
        sendMe()
        uploadUserPhoto()
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
    
    @objc private func pickPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension RegisterUserInputViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        switch textField {
        case mainView.nameInputView.textField:
            mainView.nameInputView.errorLabel.text?.removeAll()
            
            let maxCount = 30
            if replacedText.count > maxCount {
                mainView.nameInputView.errorLabel.text = "Слишком длинный. Максимум \(maxCount) символов"
                
                return false
            } else if replacedText.count > 2 {
                pendingTranslitNameRequestWorkItem?.cancel()

                let requestWorkItem = DispatchWorkItem { [weak self] in
                    if !replacedText.isEmpty {
                        self?.translitName(replacedText)
                    }
                }

                pendingTranslitNameRequestWorkItem = requestWorkItem
                DispatchQueue.main.async(execute: requestWorkItem)
            }
            
        case mainView.usernameInputView.textField:
            mainView.usernameInputView.errorLabel.text?.removeAll()
            
            return validateUsername(replacedText)
        default:
            break
        }

        return true
    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension RegisterUserInputViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            mainView.photoPlaceholderImageView.image = image
            
            picker.dismiss(animated: true)
        }
    }
    
}

// MARK: - UINavigationControllerDelegate
extension RegisterUserInputViewController: UINavigationControllerDelegate {
    
}
