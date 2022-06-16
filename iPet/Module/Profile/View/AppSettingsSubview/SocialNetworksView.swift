import UIKit
import SnapKit

class SocialNetworksView: RootView {
    
    let socialNetworksLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let socialNetworksImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        
        return image
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48.0)
    }
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.secondBackground()
        
        addSubview(socialNetworksLabel)
        addSubview(socialNetworksImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        socialNetworksLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        socialNetworksImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22.0)
        }
    }
    
}
