import UIKit
import SnapKit

class ExitContainerView: RootView {

    let exitAccountView: ExitAccountView = {
        let view = ExitAccountView()
        view.exitAccountLabel.text = "Выйти из акаунта"
        view.exitAccountImage.image = R.image.exitAccount()
        
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
