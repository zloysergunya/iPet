import UIKit
import Atributika

class FriendProfileViewController: ViewController<FriendProfileView> {
    
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
        
        view.backgroundColor = R.color.background()
        configure()
        setTarget()
    }
    
    private func configure() {
        guard let user = UserSettings.user else { return }
        
        let petName = String(user.pet?.name ?? "Имя питомца")
            .styleHashtags(Style.font(R.font.sfuiTextBold(size: 13.0) ?? .boldSystemFont(ofSize: 13.0)))
            .attributedString
        
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.friendHeaderView.animalPhotoView)
        mainView.friendHeaderView.friendNameLabel.text = user.name
        mainView.friendHeaderView.usernameLabel.text = user.username
        mainView.friendHeaderView.userLevelLabel.text = "Уровень: \(user.lvlActivity)"
        mainView.friendHeaderView.petNameLabel.text = "Питомец: \(petName)"
    }
    
    private func setTarget() {
        mainView.friendHeaderView.removeFriendButton.addTarget(self, action: #selector(removeFriendTap), for: .touchUpInside)
        mainView.friendHeaderView.challengeButton.addTarget(self, action: #selector(startChallengeTap), for: .touchUpInside)
    }
    
    @objc private func removeFriendTap() {
        print("remove friend")
    }
    
    @objc private func startChallengeTap() {
        print("start challenge")
    }
    
}
