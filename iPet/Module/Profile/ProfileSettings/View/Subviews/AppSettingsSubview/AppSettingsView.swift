import UIKit
import SnapKit

class AppSettingsView: RootView {
    
    enum AppSettingsType: Equatable {
        case switcher(isOn: Bool), propertyLabel(title: String), image(UIImage?)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = R.color.orangeAccent()
        switcher.isOn = false
        
        return switcher
    }()
    
    let imageView = UIImageView()
    
    let propertyLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.orangeAccent()
        label.font = R.font.sfuiTextSemibold(size: 18.0)
        
        return label
    }()
    
    private lazy var actionStack = UIStackView(views: [
        switcher,
        imageView,
        propertyLabel
    ], alignment: .trailing)
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.disabled()
        
        return view
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48.0)
    }

    convenience init(title: String, type: AppSettingsType) {
        self.init(frame: .zero)
        
        backgroundColor = R.color.background()
        
        addSubview(separator)
        addSubview(titleLabel)
        addSubview(actionStack)

        titleLabel.text = title
        
        switch type {
        case . switcher(let isOn):
            switcher.isOn = isOn
            switcher.isHidden = false
            imageView.isHidden = true
            propertyLabel.isHidden = true
        case .propertyLabel(title: let title):
            propertyLabel.text = title
            switcher.isHidden = true
            imageView.isHidden = true
            propertyLabel.isHidden = false
        case .image(let image):
            imageView.image = image
            switcher.isHidden = true
            imageView.isHidden = false
            propertyLabel.isHidden = true
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        actionStack.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-2.0)
            make.centerY.equalToSuperview()
        }
        
        propertyLabel.snp.makeConstraints { make in
            make.width.equalTo(80.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(22.0)
        }
        
        separator.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
