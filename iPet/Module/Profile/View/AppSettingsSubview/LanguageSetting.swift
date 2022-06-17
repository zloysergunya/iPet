import UIKit
import SnapKit

class LanguageSetting: RootView {
    
    let languagelabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let languageButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.orangeAccent(), for: .normal)
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 18.0)
        
        return button
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
        addSubview(languagelabel)
        addSubview(languageButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        languagelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        languageButton.snp.makeConstraints { make in
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
