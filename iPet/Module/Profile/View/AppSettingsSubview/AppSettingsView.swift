import UIKit
import SnapKit

class AppSettingsView: RootView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.onTintColor = R.color.orangeAccent()
        settingSwitch.isOn = false
        
        return settingSwitch
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
        addSubview(titleLabel)
        addSubview(settingSwitch)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        settingSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.right.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
