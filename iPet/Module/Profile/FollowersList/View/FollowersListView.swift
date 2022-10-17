import UIKit
import SnapKit

class FollowersListView: RootView {
    
    let searchBar = SearchBarView()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0.0, right: 16.0)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.refreshControl = UIRefreshControl()
        view.backgroundColor = .clear
        view.keyboardDismissMode = .onDrag
        
        return view
    }()
    
    let dismissView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lightGray()
        view.layer.cornerRadius = 2.0
        
        return view
    }()
    
    override func setup() {
        super.setup()
        
    }
    
    func setupConstraints() {
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(dismissView)
        
        if dismissView.isHidden {
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(layoutMarginsGuide.snp.top).inset(20.0)
                make.left.right.equalToSuperview().inset(16.0)
                make.height.equalTo(43.0)
            }
            
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
        } else {
            dismissView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(24.0)
                make.centerX.equalToSuperview()
                make.width.equalTo(36.0)
                make.height.equalTo(4)
            }
            
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(dismissView.snp.bottom).offset(20)
                make.left.right.equalToSuperview().inset(16.0)
                make.height.equalTo(43.0)
            }
            
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
        }
    }
}
