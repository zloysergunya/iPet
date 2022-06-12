import UIKit
import SnapKit

class UserMetricView: RootView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let metricLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 18.0)
        label.textColor = R.color.orangeAccent()
        label.textAlignment = .right
        
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 13.0)
        label.textColor = .gray
        label.textAlignment = .right
        
        return label
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 24.0)
    }
    
    private(set) lazy var rootStackView = UIStackView(views: [
        titleLabel,
        metricLabel,
        unitLabel
    ], axis: .horizontal, spacing: 16.0, distribution: .fillProportionally)

    override func setup() {
        super.setup()
                
        metricLabel.text = "\(5000)"
        unitLabel.text = "m"
        
        addSubview(rootStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        rootStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
