import UIKit

class HeaderProfileView: RootView {
    
    private let imageView = AnimalPhotoView()
    
    private let gradientView = GradientView(
        from: .top,
        to: .bottom,
        startColor: .init(hex: 0xFF5C00),
        endColor: .init(hex: 0xFF0003)
    )
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserSettings.user?.name
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = UserSettings.user?.username
        label.font = R.font.sfuiTextSemibold(size: 18.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = UserSettings.user?.pet?.name
        label.font = R.font.sfuiTextSemibold(size: 18.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: R.image.editButton.name), for: .normal)
        
        return button
    }()
    
    private(set) lazy var rootStackView = UIStackView(views: [
        userNameLabel,
        petNameLabel
    ], axis: .vertical, spacing: 7.0, distribution: .fillProportionally)
    
    override func setup() {
        super.setup()
        
        addSubview(gradientView)
        
        gradientView.addSubview(editProfileButton)
        gradientView.addSubview(nameLabel)
        gradientView.addSubview(imageView)
        gradientView.addSubview(rootStackView)
        
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = 10.0
        
        setupConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 115.0)
    }
    
    private func setupConstraints() {
        
        gradientView.snp.makeConstraints { make in
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
            make.top.equalToSuperview().offset(12.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalTo(editProfileButton).offset(-10.0)
        }
        
        rootStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-16.0)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.right.equalToSuperview().offset(-10.0)
            make.width.height.equalTo(20.0)
        }
    }
    
}
