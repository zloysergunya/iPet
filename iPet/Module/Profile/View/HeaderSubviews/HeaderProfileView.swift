import UIKit

class HeaderProfileView: RootView {
    
    private let gradientView = GradientView(from: .top, to: .bottom, startColor: #colorLiteral(red: 1, green: 0.3625222445, blue: 0, alpha: 1), endColor: #colorLiteral(red: 1, green: 0, blue: 0.01371841878, alpha: 1))
    private let imageView = AnimalPhotoView()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Иван"
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    private let niknameLabel: UILabel = {
        let label = UILabel()
        label.text = "Coala_034"
        label.font = R.font.sfuiTextSemibold(size: 18.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Лиснок Пуфик"
        label.font = R.font.sfuiTextSemibold(size: 18.0)
        label.textColor = R.color.textSecondary()
        
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: R.image.editButton.name), for: .normal)
        
        return button
    }()
    
    private(set) lazy var rootStackView = UIStackView(views: [
        niknameLabel,
        petNameLabel
    ], axis: .vertical, spacing: 7.0, distribution: .fillProportionally)
    
    override func setup() {
        super.setup()
        
        addSubview(gradientView)
        
        gradientView.addSubview(editProfileButton)
        gradientView.addSubview(userNameLabel)
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
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalTo(editProfileButton).offset(-10.0)
        }
        
        rootStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(14.0)
            make.left.equalTo(imageView.snp.right).offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-16.0)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.right.equalToSuperview().offset(-10.0)
            make.width.height.equalTo(20)
        }
    }
    
}
