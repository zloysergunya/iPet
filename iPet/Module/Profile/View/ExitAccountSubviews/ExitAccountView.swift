import UIKit
import SnapKit

class ExitAccountView: RootView {
    
    let exitAccountLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let exitAccountImage: UIImageView = {
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
        
        addSubview(exitAccountLabel)
        addSubview(exitAccountImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        exitAccountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        exitAccountImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(19.0)
        }
    }
    
}
