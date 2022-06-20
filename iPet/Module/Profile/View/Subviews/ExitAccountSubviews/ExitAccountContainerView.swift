import UIKit
import SnapKit

class ExitContainerView: RootView {

    let exitAccountView: AppSettingsView = {
        let view = AppSettingsView(title: "Выйти из акаунта", type: .image(R.image.exitAccount()))
        view.separator.isHidden = true
        
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
