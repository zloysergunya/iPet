import UIKit
import SnapKit

class ProfileView: RootView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()

    let userData = UserDataView()
    let userMetrics = PhysicalMetricView()
    let subscribersView = SubscribersView()
    let inviteFriendsView = IntiveFriendsView()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        
        return navigationBar
    }()
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.orangeAccentLight()
        
        return view
    }()
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.background()
        
        addSubview(scrollView)
        
        scrollView.addSubview(userData)
        scrollView.addSubview(view)
        scrollView.addSubview(userMetrics)
        scrollView.addSubview(subscribersView)
        scrollView.addSubview(inviteFriendsView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userData.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18.0)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(36.0)
        }
        
        view.snp.makeConstraints { make in
            make.top.equalTo(userData.snp.bottom)
            make.centerX.equalTo(userData.photoPlaceholderImageView.snp.centerX)
            make.width.equalTo(2.0)
            make.height.equalTo(16.0)
        }
        
        userMetrics.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.left.right.equalToSuperview().inset(36.0)
        }
        
        subscribersView.snp.makeConstraints { make in
            make.top.equalTo(userMetrics.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(26.0)
        }
        
        inviteFriendsView.snp.makeConstraints { make in
            make.top.equalTo(subscribersView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
    }
    
}
