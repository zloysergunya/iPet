import UIKit
import SnapKit

class ExitContainerView: RootView {

    let exitAccountView: AppSettingsView = {
        let view = AppSettingsView(title: "Выйти из акаунта", type: .image(R.image.exitAccount()))
        view.backgroundColor = .init(hex: 0xE3E3E3)
        
        return view
    }()

    private(set) lazy var exitAccountStackView = UIStackView(views: [
        exitAccountView
    ])
    
    override func setup() {
        super.setup()
        
        addSubview(exitAccountStackView)
        
        exitAccountStackView.layer.cornerRadius = 10.0
        exitAccountStackView.clipsToBounds = true
        
        exitAccountStackView.arrangedSubviews.enumerated().forEach { element in
            if let view = element.element as? AppSettingsView {
                view.separator.isHidden = element.offset == exitAccountStackView.arrangedSubviews.count - 1
            }
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        exitAccountStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview()
        }
        
        exitAccountView.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.0)
        }
        
        exitAccountView.imageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16.0)
            make.width.equalTo(20.0)
            make.height.equalTo(18.5)
        }
    }
    
}
