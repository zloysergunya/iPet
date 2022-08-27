import UIKit
import SnapKit

class FriendProfileView: RootView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let friendHeaderView = FriendHeaderView()
    
    override func setup() {
        super.setup()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(friendHeaderView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        friendHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
}
