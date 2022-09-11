import UIKit
import SnapKit

class UserMetricView: RootView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let metricLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 18.0)
        label.textColor = R.color.orangeAccent()
        label.textAlignment = .right
        
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 13.0)
        label.textColor = R.color.darkGray()
        label.textAlignment = .right
        
        return label
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
        
        backgroundColor = R.color.background()
        
        addSubview(titleLabel)
        addSubview(metricLabel)
        addSubview(unitLabel)
        addSubview(borderView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        metricLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-69.0)
            make.centerY.equalToSuperview()
        }
        
        unitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
