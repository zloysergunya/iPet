import UIKit
import SnapKit

class RegisterStepsInputView: RootView {

    private let imageView = UIImageView(image: R.image.stepCountFox())
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поставь свою цель!"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratBold(size: 28.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажи сколько шагов в день ты хочешь проходить, чтобы твой питомец был в форме"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratRegular(size: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.minusButton(), for: .normal)
        button.backgroundColor = R.color.blueAccent()
        button.layer.cornerRadius = 23.0
        button.tag = -100
        
        return button
    }()
    
    let stepsCountField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = R.font.montserratBold(size: 24.0)
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusButton(), for: .normal)
        button.backgroundColor = R.color.blueAccent()
        button.layer.cornerRadius = 23.0
        button.tag = 100
        
        return button
    }()
    
    let aboutKilometersLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.mainGray()
        label.font = R.font.montserratRegular(size: 16.0)
        label.textAlignment = .center
        
        return label
    }()

    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(R.color.textSecondary(), for: .normal)
        button.titleLabel?.font = R.font.montserratSemiBold(size: 17.0)
        button.setBackgroundColor(R.color.blueAccent(), for: .normal)
        button.setBackgroundColor(R.color.blueAccentDarker(), for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        
        return button
    }()

    override func setup() {
        
        backgroundColor = R.color.background()

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(minusButton)
        addSubview(stepsCountField)
        addSubview(plusButton)
        addSubview(aboutKilometersLabel)
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
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-60.0)
            make.width.equalTo(343.0)
            make.height.equalTo(247.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-16.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(stepsCountField.snp.top).offset(-40.0)
        }
        
        minusButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38.0)
            make.centerY.equalTo(stepsCountField.snp.centerY)
            make.size.equalTo(46.0)
        }
        
        stepsCountField.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right).offset(16.0)
            make.right.equalTo(plusButton.snp.left).offset(-16.0)
            make.bottom.equalTo(aboutKilometersLabel.snp.top).offset(-24.0)
        }
        
        plusButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-38.0)
            make.centerY.equalTo(stepsCountField.snp.centerY)
            make.size.equalTo(46.0)
        }
        
        aboutKilometersLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(continueButton.snp.top).offset(-16.0)
        }
        
        continueButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-56.0)
            make.height.equalTo(56.0)
        }
        
    }

}
