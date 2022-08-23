import UIKit

class ProfileViewController: ViewController<ProfileView> {

    private let provider = ProfileProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageTapRecognize()
        configure()
        navigationBar()
    }
    
    private func configure() {
        guard let user = UserSettings.user else { return }
        
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.userData.photoPlaceholderImageView)
        
        mainView.userData.nameLabel.text = user.name
        mainView.userData.userNameLabel.text = user.username
        mainView.userData.petNameLabel.text = user.pet?.name
        
        mainView.userMetrics.countStepsLabel.text = "\(user.stepsCount)/\(user.stepsCount)"
        mainView.userMetrics.countDaysLabel.text = "\(user.age)/\(user.weight)"
        
        let intiteFriendsTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(inviteFriendsTapGesture))
        mainView.inviteFriendsView.addGestureRecognizer(intiteFriendsTapRecognizer)
    }
    
    private func imageTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImageTapGesture))
        mainView.userData.photoPlaceholderImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func setImageTapGesture() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    @objc private func inviteFriendsTapGesture() {
        
    }
    
    private func navigationBar() {
        title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(settingsButton))
    }
    
    @objc func settingsButton() {
        let profileSerttingsVC = ProfileSettingsViewController()
        present(profileSerttingsVC, animated: true)
    }
    
}

// MARK: - UIImagePicker
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            mainView.userData.photoPlaceholderImageView.image = image
            loadImage()
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func loadImage() {
        guard let image = mainView.userData.photoPlaceholderImageView.image else {
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
}


