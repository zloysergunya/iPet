import UIKit
import SnapKit

class ProfileSettingsView: RootView {
        
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let profileSettingsContentView = ProfileSettingsContentView()
    
    override func setup() {
        super.setup()
        
        addSubview(scrollView)
        
        scrollView.addSubview(profileSettingsContentView)

        scrollView.backgroundColor = R.color.background()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileSettingsContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
}
