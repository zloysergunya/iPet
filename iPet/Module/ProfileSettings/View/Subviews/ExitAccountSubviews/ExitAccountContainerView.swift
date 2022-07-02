import UIKit
import SnapKit

class ExitContainerView: RootView {

    let exitAccountView = AppSettingsView(title: "Выйти из акаунта", type: .image(R.image.exitAccount()))

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
    }
    
}
