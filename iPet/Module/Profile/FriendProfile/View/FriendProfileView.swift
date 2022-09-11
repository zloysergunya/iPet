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
    let followView = FollowView()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 12.0)
        label.textColor = R.color.mainGray()
        
        return label
    }()
    
    let dateData = DataView()
    
    override func setup() {
        super.setup()
        
        addSubview(scrollView)
        
        scrollView.addSubview(friendHeaderView)
        scrollView.addSubview(followView)
        scrollView.addSubview(friendSegmentedControll)
        
        scrollView.addSubview(petNameLabel)
        scrollView.addSubview(dateData)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        friendHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.top.right.equalToSuperview()
        }
        
        followView.snp.makeConstraints { make in
            make.top.equalTo(friendHeaderView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        friendSegmentedControll.snp.makeConstraints { make in
            make.top.equalTo(followView.snp.bottom).offset(21.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(friendSegmentedControll.snp.bottom).offset(14.0)
        }

        dateData.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(21.0)
            make.left.right.equalToSuperview().inset(26.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
