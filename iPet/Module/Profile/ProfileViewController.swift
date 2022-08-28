import UIKit

class ProfileViewController: ViewController<ProfileView> {

    private let provider = ProfileProvider()
    private let petObesityLevel = UserSettings.user?.pet?.petObesityLevel

    private var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageTapRecognize()
        configure()
        navigationBar()
    }
    
    private func configure() {
        guard let user = UserSettings.user else { return }
        
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.userDataView.photoPlaceholderImageView)
        
        mainView.userDataView.nameLabel.text = user.name
        mainView.userDataView.userNameLabel.text = user.username
        mainView.userDataView.petNameLabel.text = "Питомец: \(user.pet?.name ?? "")"
        
        // TODO: - Доделать статус
        mainView.physicalMetricView.physicalStatusLabel.text = "\(PetState(rawValue: petObesityLevel ?? 0))"
        mainView.physicalMetricView.progressView.progress = Float(Double(user.stepsCount) / 8000.0)
        mainView.physicalMetricView.countStepsLabel.text = "\(Int(user.stepsCount))/8000"
        
        mainView.socialView.followersLabel.text = "Подписчики (\(user.countFollowers))"
        mainView.socialView.followingLabel.text = "Подписки (\(user.countFollowing))"
        
        // TODO: - Доделать дни
//        mainView.physicalMetricView.countDaysLabel.text = "\(user.age)/\(user.weight)"
        
        let showFollowersTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showFollowersTapGesture))
        mainView.socialView.followersImageView.addGestureRecognizer(showFollowersTapRecognizer)
        
        let showFollowingTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showFollowingTapGesture))
        mainView.socialView.followersImageView.addGestureRecognizer(showFollowingTapRecognizer)
        
        let searchFriendsTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(inviteFriendsTapGesture))
        mainView.searchBar.addGestureRecognizer(searchFriendsTapRecognizer)

        let showProgressTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProgressTapGesture))
        mainView.physicalMetricView.addGestureRecognizer(showProgressTapRecognizer)
    }
    
    private func imageTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImageTapGesture))
        mainView.userDataView.photoPlaceholderImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func setImageTapGesture() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }

    @objc private func showProgressTapGesture() {
        guard let petState = PetState(rawValue: petObesityLevel ?? 0) else {
            return
        }
        
        let viewController = ModalPhysicalStateViewController(petState: petState)
        present(viewController, animated: true)
    }
    
    @objc private func showFollowersTapGesture() {
        let viewController = FollowersListViewController()
        present(viewController, animated: true)
        print("tap")
    }
    
    @objc private func showFollowingTapGesture() {
//        let viewController = FollowersListViewController()
//        present(viewController, animated: true)
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
            mainView.userDataView.photoPlaceholderImageView.image = image
            loadImage()
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func loadImage() {
        guard let image = mainView.userDataView.photoPlaceholderImageView.image else {
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


