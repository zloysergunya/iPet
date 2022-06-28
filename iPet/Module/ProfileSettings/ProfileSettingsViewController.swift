import UIKit

class ProfileSettingsViewController: ViewController<ProfileSettingsView> {
    
    private let usernameRegularExpression = "^[a-z0-9_.-]*$"
    private let provider = ProfileSettingsProvider()
    
    private var pendingCheckAvailabilityNicknameRequestWorkItem: DispatchWorkItem?
    private var pendingTranslitNameRequestWorkItem: DispatchWorkItem?
    private var selectedPet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.profileContentView.saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        mainView.profileContentView.userTextFieldsView.nameTextField.delegate = self
        mainView.profileContentView.userTextFieldsView.userNameTextField.delegate = self
        mainView.profileContentView.userTextFieldsView.petNameTextField.delegate = self
        
        imageTapRecognize()
        configure()
    }
    
    private func configure() {
        guard let user = UserSettings.user else { return }
        
        mainView.profileContentView.userTextFieldsView.nameTextField.text = user.name
        mainView.profileContentView.userTextFieldsView.userNameTextField.text = user.username
        mainView.profileContentView.userTextFieldsView.petNameTextField.text = user.pet?.name
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.profileContentView.userImageView.circleImageView)
    }
    
    private func imageTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImageTapGesture))
        mainView.profileContentView.userImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func setImageTapGesture() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func save(_ sender: UIButton) {
        sendMe()
        uploadUserPhoto()
        updateUserPet()
    }
            
    private func uploadUserPhoto() {
        guard let image = mainView.profileContentView.userImageView.circleImageView.image else {
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
    
    private func updateUserPet() {
        guard let userPetId = UserSettings.user?.pet?.pet.id else { return }
        
        guard let petName = mainView.profileContentView.userTextFieldsView.petNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !petName.isEmpty else {
            Animations.shake(view: mainView.profileContentView.userTextFieldsView.petNameTextField)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        provider.updateUserPet(userPetId: userPetId, userPetUserPetIdRequest: UserPetUserPetIdRequest(name: petName)) { [weak self] result in
            switch result {
            case .success:
                UserSettings.user?.pet?.name = petName
                
            case .failure(let error):
                break
            }
        }
    }
    
    private func sendMe() {
        guard mainView.profileContentView.userTextFieldsView.errorLabel.text != "Никнейм уже занят" else {
            Animations.shake(view: mainView.profileContentView.userTextFieldsView.errorLabel)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        guard let name = mainView.profileContentView.userTextFieldsView.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            Animations.shake(view: mainView.profileContentView.userTextFieldsView.nameTextField)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        guard let username = mainView.profileContentView.userTextFieldsView.userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !username.isEmpty else {
            Animations.shake(view: mainView.profileContentView.userTextFieldsView.userNameTextField)
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
                self?.dismiss(animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func choicePet() {
        guard let petId = selectedPet?.id else {
            return
        }
        
        provider.choicePet(petId: petId) { [weak self] result in
            switch result {
            case .success:
                self?.changePetName()
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func changePetName() {
        guard let petId = selectedPet?.id else {
            return
        }
        
        guard let name = mainView.profileContentView.userTextFieldsView.petNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            Animations.shake(view: mainView.profileContentView.userTextFieldsView.petNameTextField)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        provider.changePetName(petId: petId, name: name) { [weak self] result in
            switch result {
            case .success:
                self?.dismiss(animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func checkAvailabilityNickname(_ username: String) {
        provider.checkAvailabilityNickname(username) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let used):
                if used, let text = self.mainView.profileContentView.userTextFieldsView.userNameTextField.text, username == text {
                    self.mainView.profileContentView.userTextFieldsView.errorLabel.text = "Никнейм уже занят"
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
                self?.mainView.profileContentView.userTextFieldsView.userNameTextField.text = username
                
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
        
        mainView.profileContentView.userTextFieldsView.errorLabel.text?.removeAll()
        
        if username.count < minCount {
            if match {
                mainView.profileContentView.userTextFieldsView.errorLabel.text = "Слишком короткий. Минимум \(minCount) символов"
            } else {
                mainView.profileContentView.userTextFieldsView.errorLabel.text = "Используй латинские буквы и цифры"
            }
        }

        if username.count > maxCount {
            mainView.profileContentView.userTextFieldsView.errorLabel.text = "Слишком длинный. Максимум \(maxCount) символов"
            
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
}

// MARK: - UITextFieldDelegate
extension ProfileSettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        switch textField {
        case mainView.profileContentView.userTextFieldsView.nameTextField:
            mainView.profileContentView.userTextFieldsView.errorLabel.text?.removeAll()
            
            let maxCount = 30
            if replacedText.count > maxCount {
                mainView.profileContentView.userTextFieldsView.errorLabel.text = "Слишком длинный. Максимум \(maxCount) символов"
                
                return false
            } else if replacedText.count > 2 {
                pendingTranslitNameRequestWorkItem?.cancel()

                let requestWorkItem = DispatchWorkItem { [weak self] in
                    if !replacedText.isEmpty {
                        self?.translitName(replacedText)
                    }
                }

                pendingTranslitNameRequestWorkItem = requestWorkItem
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: requestWorkItem)
            }
            
        case mainView.profileContentView.userTextFieldsView.userNameTextField:
            mainView.profileContentView.userTextFieldsView.errorLabel.text?.removeAll()
            
            return validateUsername(replacedText)
        default:
            break
        }

        return true
    }
}

// MARK: - UIImagePicker
extension ProfileSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            mainView.profileContentView.userImageView.circleImageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
