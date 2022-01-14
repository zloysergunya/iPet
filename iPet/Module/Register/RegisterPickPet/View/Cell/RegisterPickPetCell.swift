import UIKit
import PinLayout
import Lottie

class RegisterPickPetCell: UICollectionViewCell {
    
    let petAnimationView: AnimationView = {
        let view = AnimationView()
        view.animationSpeed = 1.0
        view.loopMode = .loop
        
        return view
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.montserratRegular(size: 17.0)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(petAnimationView)
        contentView.addSubview(petNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        
        petAnimationView.pin.above(of: petNameLabel).marginBottom(12.0).left().top().right()
        petNameLabel.pin.left().bottom().right().height(22.0)
        
    }
    
}
