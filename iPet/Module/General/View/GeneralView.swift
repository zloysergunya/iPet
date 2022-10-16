import UIKit
import SnapKit

class GeneralView: RootView {
    
    let shopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "petShop"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 12.0)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 20.0)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let petLevelLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 12.0)
        label.textColor = UIColor(hex: 0x6E6C6B)
        label.textAlignment = .center
        
        return label
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.photoPlaceholder(), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let petStatusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.0
        
        return view
    }()
    
    let petStatusLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 13.0)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let petStateHelpImageView = UIImageView(image: R.image.petStateHelp())
    
    let petStateLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 11.0)
        label.textColor = .black
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let animatedPetView = AnimatedPetView()
    let achivmentsView = AchivmentsView()
    
    private let blurView: VisualEffectView = {
        let blurView = VisualEffectView()
        blurView.blurRadius = 1.0
        blurView.colorTint = UIColor.white.withAlphaComponent(0.05)
        blurView.isUserInteractionEnabled = false
        
        return blurView
    }()
    
    let radialGradientView = RadialGradientView()
    let mainActivityProgressView = MainActivityProgressView()

    override func setup() {
        super.setup()
        
        backgroundColor = .white
        
        addSubview(radialGradientView)
        addSubview(achivmentsView)
        addSubview(blurView)
        addSubview(shopButton)
        addSubview(petNameLabel)
        addSubview(petLevelLabel)
        addSubview(profileButton)
        addSubview(animatedPetView)
        addSubview(petStatusLabel)
        addSubview(petStatusView)
        addSubview(petStateLabel)
        addSubview(petStateHelpImageView)
        addSubview(mainActivityProgressView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        radialGradientView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(600.0)
        }
        
        blurView.snp.makeConstraints { make in
            make.top.equalTo(petLevelLabel.snp.bottom).offset(46.0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(radialGradientView.snp.bottom)
        }
        
        shopButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18.0)
            make.left.equalToSuperview().offset(21.0)
            make.size.equalTo(40.0)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.centerX.equalToSuperview()
        }
        
        petLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(4.0)
            make.centerX.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18.0)
            make.right.equalToSuperview().offset(-16.0)
            make.size.equalTo(40.0)
        }
        
        animatedPetView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(petStateLabel.snp.top).offset(-32.0)
        }
        
        petStateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainActivityProgressView.snp.top).offset(-50.0)
        }
        
        petStateHelpImageView.snp.makeConstraints { make in
            make.left.equalTo(petStateLabel.snp.right).offset(2.0)
            make.centerY.equalTo(petStateLabel.snp.centerY)
            make.size.equalTo(12.0)
        }
        
        petStatusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(petStateLabel.snp.top).offset(-4.0)
        }
        
        petStatusView.snp.makeConstraints { make in
            make.centerY.equalTo(petStatusLabel.snp.centerY)
            make.right.equalTo(petStatusLabel.snp.left).offset(-10.0)
            make.size.equalTo(8.0)
        }
        
        achivmentsView.snp.makeConstraints { make in
            make.top.equalTo(petLevelLabel.snp.bottom).offset(46.0)
            make.left.right.equalToSuperview().inset(28.0)
            make.bottom.equalTo(petStateLabel.snp.top).offset(-48.0)
        }
        
        mainActivityProgressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30.0)
            make.height.equalTo(94.0)
        } 
    }
    
}
