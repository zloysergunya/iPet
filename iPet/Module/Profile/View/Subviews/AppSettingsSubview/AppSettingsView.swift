import UIKit
import SnapKit

class AppSettingsView: RootView {
    
    enum AppSettingsType: Equatable {
        case switcher(isOn: Bool), button(title: String), image(UIImage?)
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
    
    private let imageView = UIImageView()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.orangeAccent(), for: .normal)
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 18.0)
        
        return button
    }()
    
    private lazy var actionStack = UIStackView(views: [
        switcher,
        imageView,
        button
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
        
        backgroundColor = R.color.secondBackground()
        
        addSubview(separator)
        addSubview(titleLabel)
        addSubview(actionStack)

        titleLabel.text = title
        
        switch type {
        case . switcher(let isOn):
            switcher.isOn = isOn
            switcher.isHidden = false
            imageView.isHidden = true
            button.isHidden = true
        case .button(title: let title):
            button.setTitle(title, for: .normal)
            switcher.isHidden = true
            imageView.isHidden = true
            button.isHidden = false
        case .image(let image):
            imageView.image = image
            switcher.isHidden = true
            imageView.isHidden = false
            button.isHidden = true
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
            make.centerY.equalToSuperview()
        }
        
        actionStack.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(80.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24.0)
        }
        
        separator.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
}
