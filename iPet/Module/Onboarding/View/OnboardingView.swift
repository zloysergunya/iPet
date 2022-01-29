import UIKit
import SnapKit

class OnboardingView: RootView {
    
    private let maskotImageView = UIImageView(image: R.image.foxMascote())
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratBold(size: 28.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет! Давай знакомиться :)"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratRegular(size: 16.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private let petPageContoll = UIImageView(image: R.image.petPageContollStep1())
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(maskotImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(petPageContoll)
        
        return view
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

        addSubview(containerView)
        addSubview(continueButton)
        
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
        
        continueButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-56.0)
            make.height.equalTo(56.0)
        }
        
    }

}
