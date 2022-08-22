import UIKit
import SnapKit

class GenderView: RootView {
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let genderImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        
        
        return image
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48.0)
    }
    
    override func setup() {
        super.setup()

        backgroundColor = R.color.secondBackground()
        
        addSubview(genderLabel)
        addSubview(genderImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        genderImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(18.0)
        }
    }
    
}
    

