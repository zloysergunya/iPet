import UIKit
import SnapKit

class ProfileSettingsView: RootView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private let profileContentView = ProfileSettingsContentView()
    
    override func setup() {
        super.setup()
        
        addSubview(scrollView)
        
        scrollView.addSubview(profileContentView)

        scrollView.backgroundColor = R.color.background()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
}
