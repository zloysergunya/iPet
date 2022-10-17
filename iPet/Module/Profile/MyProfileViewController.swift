import UIKit
import Atributika

class MyProfileViewController: ViewController<MyProfileView> {

    private let provider = ProfileProvider()
    private let petObesityLevel = UserSettings.user?.pet?.petObesityLevel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageTapRecognize()
        configure()
        navigationBar()
        getFollowers()
        getFollowing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configure() {
        guard let user = UserSettings.user else { return }
        
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.userDataView.photoPlaceholderImageView)
        
        mainView.userDataView.nameLabel.text = user.name
        mainView.userDataView.userNameLabel.text = user.username
        
        if let petName = user.pet?.name {
            let text = "Питомец: <bold>\(petName)</bold>"
            let bold = Style("bold").font(R.font.sfuiTextBold(size: 13.0) ?? .systemFont(ofSize: 13.0, weight: .bold))
            mainView.userDataView.petNameLabel.attributedText = text.style(tags: bold).attributedString
        }
        
        // TODO: - Доделать статус
//        mainView.physicalMetricView.physicalStatusLabel.text = "\(PetState(rawValue: petObesityLevel ?? 0))"
        mainView.physicalMetricView.progressView.progress = Float(Double(user.stepsCount) / 8000.0)
        mainView.physicalMetricView.countStepsLabel.text = "\(Int(user.stepsCount))/8000"
//        ImageLoader.setImage(url: user.pet?.pet.staticPhoto, imageView: mainView.physicalMetricView.petImage)

//        \(stats.steps_goal)"
        
        mainView.followView.followers.titleLabel.text = "Подписчики (\(user.countFollowers))"
        mainView.followView.following.titleLabel.text = "Подписки (\(user.countFollowing))"
        
        // TODO: - Доделать дни
//        mainView.physicalMetricView.countDaysLabel.text = "\(user.age)/\(user.weight)"
        
        let showFollowersTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showFollowersTapGesture))
        mainView.followView.followers.addGestureRecognizer(showFollowersTapRecognizer)
        
        let showFollowingTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showFollowingTapGesture))
        mainView.followView.following.addGestureRecognizer(showFollowingTapRecognizer)
        
        let showAllUsersTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAllUsersTapGesture))
        mainView.searchBar.addGestureRecognizer(showAllUsersTapRecognizer)

        let showProgressTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProgressTapGesture))
        mainView.physicalMetricView.addGestureRecognizer(showProgressTapRecognizer)
    }
    
    private func imageTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImageTapGesture))
        mainView.userDataView.photoPlaceholderImageView.addGestureRecognizer(tapRecognizer)
    }
    
    private func navigationBar() {
        title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.settingsButton(), style: .done, target: self, action: #selector(showProfileSettingsVC))
    }
    
    private func getFollowers() {
        provider.userFollowersGet { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.setupSocialView(users: users, view: self.mainView.followView.followers)
            case .failure(let error):
                self.showError(text: error.localizedDescription)
            }
        }
    }
    
    private func getFollowing() {
        provider.userFollowingGet { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.setupSocialView(users: users, view: self.mainView.followView.following)
            case .failure(let error):
                self.showError(text: error.localizedDescription)
            }
        }
    }
    
    private func setupSocialView(users: [User], view: SocialView) {
        view.userStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        users.prefix(6).forEach { user in
            let imageView = UIImageView()
            let side = 31.0
            imageView.layer.cornerRadius = side / 2
            imageView.clipsToBounds = true
            imageView.snp.makeConstraints { make in
                make.size.equalTo(side)
            }
            imageView.contentMode = .scaleAspectFill
            ImageLoader.setImage(url: user.avatarURL, imageView: imageView)
            view.userStackView.addArrangedSubview(imageView)
        }
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
        let viewController = FollowersListViewController(type: .followers)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showFollowingTapGesture() {
        let viewController = FollowersListViewController(type: .following)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showAllUsersTapGesture() {
        let viewController = FollowersListViewController(type: .all)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.present(viewController, animated: true)
    }
    
    @objc func showProfileSettingsVC() {
        let viewController = ProfileSettingsViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - UIImagePicker
extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
