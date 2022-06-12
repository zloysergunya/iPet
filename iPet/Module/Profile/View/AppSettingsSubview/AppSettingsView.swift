import UIKit
import SnapKit

class AppSettingsView: RootView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.onTintColor = R.color.blueAccent()
        
        return settingSwitch
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 31.0)
    }
    
    private(set) lazy var rootStackView = UIStackView(views: [
        titleLabel,
        settingSwitch,
    ], axis: .horizontal, distribution: .equalSpacing)

    override func setup() {
        super.setup()
        
        addSubview(rootStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        rootStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
