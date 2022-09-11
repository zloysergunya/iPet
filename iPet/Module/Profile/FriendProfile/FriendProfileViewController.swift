import UIKit
import Atributika

enum UserStatisticPeriod: Int {
    case day, week, month
}

class FriendProfileViewController: ViewController<FriendProfileView> {
    
    private let user: User
    private var userFull: UserMeResponce?
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.friendSegmentedControll.segmentedControll.addTarget(self, action: #selector(changeSegmentControl), for: .valueChanged)
        
        view.backgroundColor = R.color.background()
        configure()
        setTarget()
    }
    
    private func configure() {
        
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.friendHeaderView.animalPhotoView)
        mainView.friendHeaderView.friendNameLabel.text = user.name
        mainView.friendHeaderView.usernameLabel.text = user.username
        mainView.friendHeaderView.levelLabel.text = "\(user.lvlActivity)"
        
        // TODO: - доделать
        mainView.followView.followers.titleLabel.text = "Награды(0)"
        mainView.followView.following.titleLabel.text = "Подписки(150)"
        
        if let petName = user.pet?.name {
            let text = "Питомец: <bold>\(petName)</bold>"
            let bold = Style("bold")
                .font(R.font.sfuiTextSemibold(size: 13.0) ?? .systemFont(ofSize: 13.0, weight: .bold))
                .foregroundColor(R.color.textTF() ?? .black)
                        
            mainView.petNameLabel.attributedText = text.style(tags: bold).attributedString
        }
        
        if let period = UserStatisticPeriod(rawValue: mainView.friendSegmentedControll.segmentedControll.selectedSegmentIndex) {
            switch period {
            case .day:
                mainView.dateData.distanceCount.stateLabel.text = "day"
            case .week:
                mainView.dateData.distanceCount.stateLabel.text = "week"
            case .month:
                mainView.dateData.distanceCount.stateLabel.text = "month"
            }
        }
    }
    
    @objc func changeSegmentControl(_ segmentedControl: UISegmentedControl) {
        if let period = UserStatisticPeriod(rawValue: segmentedControl.selectedSegmentIndex) {
            switch period {
            case .day:
                mainView.dateData.distanceCount.stateLabel.text = "day"
            case .week:
                mainView.dateData.distanceCount.stateLabel.text = "week"
            case .month:
                mainView.dateData.distanceCount.stateLabel.text = "month"
            }
        }
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
