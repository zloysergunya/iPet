import UIKit

class HeaderProfileSettingsView: RootView {
    
    let imageView = AnimalPhotoView()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: 0xFF6B00)
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserSettings.user?.name
        label.font = R.font.sfuiTextBold(size: 20.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = UserSettings.user?.username
        label.font = R.font.sfuiTextSemibold(size: 12.0)
        label.textColor = .init(hex: 0xE3E3E3)
        
        return label
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = UserSettings.user?.pet?.name
        label.font = R.font.sfuiTextSemibold(size: 14.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: R.image.editButton.name), for: .normal)
        
        return button
    }()
    
    override func setup() {
        super.setup()
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10.0
                
        setupConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 115.0)
    }
    
    private func setupConstraints() {
        addSubview(backgroundView)
        
        backgroundView.addSubview(editProfileButton)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(userNameLabel)
        backgroundView.addSubview(petNameLabel)
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().offset(12.0)
            make.width.height.equalTo(87.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalTo(editProfileButton.snp.left).offset(-10.0)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalTo(editProfileButton.snp.left).offset(-10.0)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalTo(editProfileButton.snp.left).offset(-10.0)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.right.equalToSuperview().offset(-10.0)
            make.width.height.equalTo(20.0)
        }
    }
    
}
