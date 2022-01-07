import UIKit
import SnapKit

class RegisterUserInputView: RootView {
    
    private let addPhotoImageView = UIImageView(image: R.image.registerAddPhoto())
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Как тебя зовут?"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratBold(size: 28.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введи свое имя и никнейм, установи фото профиля"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratRegular(size: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let nameInputView: RegisterInputView = {
        let inputView = RegisterInputView()
        inputView.textField.placeholder = "Имя"
        
        return inputView
    }()
    
    let usernameInputView: RegisterInputView = {
        let inputView = RegisterInputView()
        inputView.textField.autocapitalizationType = .none
        inputView.textField.keyboardType = .asciiCapable
        inputView.textField.placeholder = "Юзернейм"
                
        return inputView
    }()

    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(R.color.textSecondary(), for: .normal)
        button.titleLabel?.font = R.font.montserratSemiBold(size: 17.0)
        button.backgroundColor = R.color.blueAccent()
        button.layer.cornerRadius = 10.0
        
        return button
    }()

    override func setup() {
        
        backgroundColor = R.color.background()

        addSubview(addPhotoImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(nameInputView)
        addSubview(usernameInputView)
        addSubview(continueButton)
        
        setupConstraints()
    }
    
    func updateButtonBottomConstraint(duration: Double, _ offset: Double = -56.0) {
        UIView.animate(withDuration: duration) {
            self.continueButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(offset)
            }
            
            self.layoutIfNeeded()
        }
    }
    
    private func setupConstraints() {
        
        addPhotoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-134.0)
            make.size.equalTo(108.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-16.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(nameInputView.snp.top).offset(-20.0)
        }
        
        nameInputView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(usernameInputView.snp.top).offset(-12.0)
        }
        
        usernameInputView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(continueButton.snp.top).offset(-12.0)
        }
        
        continueButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-56.0)
            make.height.equalTo(56.0)
        }
        
    }
    
}
