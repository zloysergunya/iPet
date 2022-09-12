import UIKit
import Atributika

enum UserStatisticPeriod: Int {
    case day, week, month
}

class FriendProfileViewController: ViewController<FriendProfileView> {
    
    private let user: User
    private let provider = FriendProfileProvider()
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
        showContent()
        getFollowing()
    }
    
    private func configure() {
        
        ImageLoader.setImage(url: user.avatarURL, imageView: mainView.friendHeaderView.animalPhotoView)
        mainView.friendHeaderView.friendNameLabel.text = user.name
        mainView.friendHeaderView.usernameLabel.text = user.username
        mainView.friendHeaderView.levelLabel.text = "\(user.lvlActivity)"
        
        // TODO: - доделать
        mainView.followView.followers.titleLabel.text = "Награды(0)"
        mainView.followView.following.titleLabel.text = "Подписки (\(user.countFollowing))"
        
        if let petName = user.pet?.name {
            let text = "Питомец: <bold>\(petName)</bold>"
            let bold = Style("bold")
                .font(R.font.sfuiTextSemibold(size: 13.0) ?? .systemFont(ofSize: 13.0, weight: .bold))
                .foregroundColor(R.color.textTF() ?? .black)
                        
            mainView.petNameUnsubscribeLabel.attributedText = text.style(tags: bold).attributedString
            mainView.petNameSubscribeLabel.attributedText = text.style(tags: bold).attributedString
        }
        
        let showFollowingTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showFollowingTapGesture))
        mainView.followView.following.addGestureRecognizer(showFollowingTapRecognizer)
        
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
    
    private func showContent() {
        mainView.friendHeaderView.removeFriendButton.isHidden = user.follow
        mainView.friendHeaderView.challengeButton.isHidden = user.follow
        mainView.friendSegmentedControll.isHidden = user.follow
        mainView.statistic.isHidden = user.follow
        mainView.petNameSubscribeLabel.isHidden = user.follow
        mainView.dateData.isHidden = user.follow
        
        mainView.subscribeButton.isHidden = !user.follow
        mainView.petNameUnsubscribeLabel.isHidden = !user.follow
        mainView.userPetImageView.isHidden = !user.follow
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
    
    private func getFollowing() {
        provider.userFollowingGet { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.setupSocialView(users: users, view: self.mainView.followView.following)
            case .failure(let error):
                log.error(error.localizedDescription)
            }
        }
    }
    
    private func setupSocialView(users: [User], view: SocialView) {
        view.userStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        users.prefix(6).forEach { user in
            let imageView = UIImageView()
            let side = 31.0
            imageView.layer.cornerRadius = side / 2
            imageView.snp.makeConstraints { make in
                make.size.equalTo(side)
            }
            imageView.contentMode = .scaleAspectFill
            ImageLoader.setImage(url: user.avatarURL, imageView: imageView)
            view.userStackView.addArrangedSubview(imageView)
        }
    }
    
    @objc private func removeFriendTap() {
        print("remove friend")
    }
    
    @objc private func startChallengeTap() {
        print("start challenge")
    }
    
    @objc private func showFollowingTapGesture() {
        let viewController = FollowersListViewController(type: .following)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
