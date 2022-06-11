import UIKit
import SnapKit
import Atributika

class SignInView: RootView {

    private let maskotImageView = UIImageView(image: R.image.foxMascote())
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratBold(size: 28.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери способ авторизации"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratRegular(size: 16.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private let petPageContoll = UIImageView(image: R.image.petPageContollStep2())
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(maskotImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(petPageContoll)
        
        return view
    }()
    
    let appleAuthButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.appleLogo(), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 4.0, right: 12.0)
        button.setTitle("Войти с помощью Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = R.font.montserratSemiBold(size: 17.0)
        button.setBackgroundColor(.black, for: .normal)
        button.setBackgroundColor(.black.withAlphaComponent(0.8), for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        button.adjustsImageWhenHighlighted = false
        
        return button
    }()
    
    let googleAuthButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.googleLogo(), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 12.0)
        button.setTitle("Войти с помощью Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = R.font.montserratSemiBold(size: 17.0)
        button.setBackgroundColor(UIColor(hex: 0xE95144), for: .normal)
        button.setBackgroundColor(UIColor(hex: 0xAA4037), for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        button.adjustsImageWhenHighlighted = false
        
        return button
    }()
    
    let privacyLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.font = R.font.montserratRegular(size: 14.0) ?? .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = R.color.textPrimary() ?? .black
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12.0
        stackView.addArrangedSubview(appleAuthButton)
        stackView.addArrangedSubview(googleAuthButton)
        
        return stackView
    }()
    
    override func setup() {
        
        backgroundColor = R.color.background()

        addSubview(containerView)
        addSubview(stackView)
        addSubview(privacyLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        maskotImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(-16.0)
            make.width.equalTo(210.0)
            make.height.equalTo(184.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(maskotImageView.snp.bottom).offset(76.0)
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
        }
        
        petPageContoll.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16.0)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(26.0)
            make.width.equalTo(94.0)
        }
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        appleAuthButton.snp.makeConstraints { make in
            make.height.equalTo(56.0)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-56.0)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(20.0)
        }
    }

}
