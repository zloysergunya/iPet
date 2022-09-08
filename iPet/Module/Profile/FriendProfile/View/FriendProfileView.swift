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
    let friendSegmentedControll = FriendSegmentedControllView()
    
    let dateData = DataView()
    
    override func setup() {
        super.setup()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        
        scrollView.addSubview(friendHeaderView)
        scrollView.addSubview(friendSegmentedControll)
        
        scrollView.addSubview(dateData)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        friendHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.top.right.equalToSuperview()
        }
        
        friendSegmentedControll.snp.makeConstraints { make in
            make.top.equalTo(friendHeaderView.snp.bottom).offset(21.0)
            make.left.right.equalToSuperview().inset(16.0)
        }

        dateData.snp.makeConstraints { make in
            make.top.equalTo(friendSegmentedControll.snp.bottom).offset(21.0)
            make.left.right.equalToSuperview().inset(26.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
