import UIKit
import SnapKit

class GeneralView: RootView {
    
    let shopButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.petShop(), for: .normal)
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
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }()
    
    let petStatusLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 13.0)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
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
        addSubview(petStateLabel)
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.left.equalToSuperview().offset(16.0)
            make.height.equalTo(40.0)
            make.width.greaterThanOrEqualTo(44.0)
        }
        
        shopButton.imageView?.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.width.equalTo(44.0)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(14.0)
            make.centerX.equalToSuperview()
        }
        
        petLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(4.0)
            make.centerX.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.size.equalTo(40.0)
        }
        
        animatedPetView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(petStateLabel.snp.top).offset(-32.0)
        }
        
        petStateLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36.0)
            make.bottom.equalTo(mainActivityProgressView.snp.top).offset(-50.0)
        }
        
        petStatusLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36.0)
            make.bottom.equalTo(petStateLabel.snp.top).offset(-4.0)
        }
        
        achivmentsView.snp.makeConstraints { make in
            make.top.equalTo(petLevelLabel.snp.bottom).offset(46.0)
            make.left.right.equalToSuperview().inset(28.0)
            make.bottom.equalTo(petStateLabel.snp.top).offset(-48.0)
        }
        
        mainActivityProgressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-36.0)
            make.height.equalTo(94.0)
        } 
    }
    
}
