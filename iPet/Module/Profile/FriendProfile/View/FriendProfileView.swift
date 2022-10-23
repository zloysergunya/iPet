import UIKit
import SnapKit

class FriendProfileView: RootView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let friendHeaderView = FriendHeaderView()
    let friendSegmentedControll = FriendSegmentedControllView()
    let followView = FollowView()
    let statistic = UIImageView(image: UIImage(named: "statistic"))
    
    let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подписаться", for: .normal)
        button.setTitleColor(R.color.background(), for: .normal)
        button.setBackgroundColor(R.color.orangeAccent(), for: .normal)
        button.setTitle("Запрос отправлен", for: .selected)
        button.setTitleColor(R.color.darkGray(), for: .selected)
        button.setBackgroundColor(R.color.disabled(), for: .selected)
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 17.0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        
        return button
    }()
    
    let petNameSubscribeLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 12.0)
        label.textColor = R.color.mainGray()
        
        return label
    }()
    
    let petNameUnsubscribeLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 12.0)
        label.textColor = R.color.mainGray()
        
        return label
    }()
    
    let userPetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.lemur()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let dateData = DataView()
    
    override func setup() {
        super.setup()
        
        addSubview(scrollView)
        
        scrollView.addSubview(friendHeaderView)
        scrollView.addSubview(followView)
        scrollView.addSubview(friendSegmentedControll)
        
        scrollView.addSubview(statistic)
        scrollView.addSubview(petNameSubscribeLabel)
        scrollView.addSubview(dateData)
        
        scrollView.addSubview(subscribeButton)
        scrollView.addSubview(petNameUnsubscribeLabel)
        scrollView.addSubview(userPetImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        friendHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.top.right.equalToSuperview()
        }
        
        followView.snp.makeConstraints { make in
            make.top.equalTo(friendHeaderView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        subscribeButton.snp.makeConstraints { make in
            make.top.equalTo(followView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
            make.height.equalTo(56.0)
        }
        
        petNameUnsubscribeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subscribeButton.snp.bottom ).offset(30.0)
        }
        
        userPetImageView.snp.makeConstraints { make in
            make.top.equalTo(petNameUnsubscribeLabel.snp.bottom).offset(36.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(165.0)
            make.width.equalTo(135.0)
        }
        
        friendSegmentedControll.snp.makeConstraints { make in
            make.top.equalTo(followView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        statistic.snp.makeConstraints { make in
            make.top.equalTo(friendSegmentedControll.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
            make.height.equalTo(110.0)
        }
        
        petNameSubscribeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(statistic.snp.bottom ).offset(14.0)
        }

        dateData.snp.makeConstraints { make in
            make.top.equalTo(petNameSubscribeLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(26.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
