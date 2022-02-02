import UIKit
import SnapKit
import IGListKit

class RegisterPickPetView: RootView {
    
    let collectionViewLayout: PagingFlowLayout = {
        let collectionViewLayout = PagingFlowLayout()
        collectionViewLayout.zoomFactor = 0.25
        collectionViewLayout.activeDistance = 100.0
        
        return collectionViewLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        let width = 240.0
        let offset = (UIScreen.main.bounds.width - width) / 2
        view.contentInset = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: offset)
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.decelerationRate = .fast
        
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Твой друг"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratBold(size: 28.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери питомца и назови его"
        label.textColor = R.color.textPrimary()
        label.font = R.font.montserratRegular(size: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    private let petPageContoll = UIImageView(image: R.image.petPageContollStep4())
    
    let generatePetNameButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.petRandomNameIcon(), for: .normal)
        
        return button
    }()
    
    let petNameInputView: RegisterInputView = {
        let inputView = RegisterInputView()
        inputView.textField.placeholder = "Кличка питомца"
        
        return inputView
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

        addSubview(collectionView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(petPageContoll)
        addSubview(petNameInputView)
        addSubview(generatePetNameButton)
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
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-16.0)
            make.height.equalTo(300.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-16.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(petPageContoll.snp.top).offset(-20.0)
        }
        
        petPageContoll.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(petNameInputView.snp.top).offset(-72.0)
            make.height.equalTo(26.0)
            make.width.equalTo(94.0)
        }
        
        petNameInputView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(continueButton.snp.top).offset(-12.0)
        }
        
        generatePetNameButton.snp.makeConstraints { make in
            make.right.equalTo(petNameInputView.snp.right).offset(-8.0)
            make.bottom.equalTo(petNameInputView.snp.bottom).offset(-16.0)
            make.size.equalTo(48.0)
        }

        continueButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview().offset(-56.0)
            make.height.equalTo(56.0)
        }
        
    }
}
