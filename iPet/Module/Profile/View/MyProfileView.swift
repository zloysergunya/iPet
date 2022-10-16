import UIKit
import SnapKit

class MyProfileView: RootView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()

    let userDataView = UserDataView()
    let physicalMetricView = PhysicalMetricView()
    let followView = FollowView()
    let searchBar = SearchBarView()
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.orangeAccentLight()
        
        return view
    }()
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.background()
        
        addSubview(scrollView)
        
        scrollView.addSubview(userDataView)
        scrollView.addSubview(view)
        scrollView.addSubview(physicalMetricView)
        scrollView.addSubview(followView)
        scrollView.addSubview(searchBar)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userDataView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18.0)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(26.0)
        }
        
        view.snp.makeConstraints { make in
            make.top.equalTo(userDataView.snp.bottom)
            make.centerX.equalTo(userDataView.photoPlaceholderImageView.snp.centerX)
            make.width.equalTo(2.0)
            make.height.equalTo(16.0)
        }
        
        physicalMetricView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.left.right.equalToSuperview().inset(26.0)
        }
        
        followView.snp.makeConstraints { make in
            make.top.equalTo(physicalMetricView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(26.0)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(followView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(26.0)
            make.bottom.equalToSuperview()
            make.height.equalTo(43.0)
        }
    }
    
}
