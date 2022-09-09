import UIKit

class FriendHeaderView: UIView {
    
    let animalPhotoView: AnimalPhotoView = {
        let imageView = AnimalPhotoView()
        imageView.layer.borderColor = R.color.orangeAccent()?.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.image = R.image.lama()
        
        return imageView
    }()
    
    let levelView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.orangeAccent()
        
        return view
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 14.0)
        label.textColor = R.color.textSecondary()
        label.text = "2"
        
        return label
    }()
    
    let removeFriendButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.removeFriend(), for: .normal)
        
        return button
    }()
    
    let challengeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.challenge(), for: .normal)
        
        return button
    }()
    
    let friendNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = .black
        
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 12.0)
        label.textColor = R.color.grayText()
        
        return label
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 13.0)
        label.textColor = .black
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        animalPhotoView.layer.cornerRadius = animalPhotoView.frame.height / 2
        levelView.layer.cornerRadius = levelView.frame.height / 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(animalPhotoView)
        addSubview(levelView)
        addSubview(removeFriendButton)
        addSubview(challengeButton)
        addSubview(friendNameLabel)
        addSubview(usernameLabel)
        addSubview(petNameLabel)
        
        levelView.addSubview(levelLabel)
        
        animalPhotoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(98.0)
        }
        
        levelView.snp.makeConstraints { make in
            make.center.equalTo(animalPhotoView).offset(35.0)
            make.size.equalTo(24.0)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        removeFriendButton.snp.makeConstraints { make in
            make.centerY.equalTo(animalPhotoView)
            make.right.equalTo(animalPhotoView.snp.left).offset(-47.0)
            make.width.equalTo(38.0)
            make.height.equalTo(37.0)
        }
        
        challengeButton.snp.makeConstraints { make in
            make.centerY.equalTo(animalPhotoView)
            make.left.equalTo(animalPhotoView.snp.right).offset(47.0)
            make.width.equalTo(38.0)
            make.height.equalTo(37.0)
        }
        
        friendNameLabel.snp.makeConstraints { make in
            make.top.equalTo(animalPhotoView.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(friendNameLabel.snp.bottom).offset(7.0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
