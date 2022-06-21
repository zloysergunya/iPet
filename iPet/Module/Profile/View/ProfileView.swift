import UIKit
import SnapKit

class ProfileView: RootView {
        
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let profileContentView = ProfileContentView()
    
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
