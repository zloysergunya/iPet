import UIKit
import SnapKit

class RecalView: RootView {
    
    let recallLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let recallImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        
        return image
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.disabled()
        
        return view
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48.0)
    }
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.secondBackground()
        
        addSubview(borderView)
        addSubview(recallLabel)
        addSubview(recallImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        recallLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        recallImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20.0)
        }
        
        borderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
  
