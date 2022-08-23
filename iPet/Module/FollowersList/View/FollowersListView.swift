import UIKit
import SnapKit

class FollowersListView: RootView {
    
    let searchBar = SearchBarView()
    
    let globalSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.globalSearch(), for: .normal)
        button.contentMode = .scaleAspectFill
        
        return button
    }()
        
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
    
    override func setup() {
        super.setup()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(searchBar)
        addSubview(globalSearchButton)
        addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top).inset(20.0)
            make.left.equalToSuperview().inset(16.0)
            make.right.equalTo(globalSearchButton.snp.left).offset(-16.0)
            make.height.equalTo(43.0)
        }
        
        globalSearchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.right.equalToSuperview().inset(16.0)
            make.size.equalTo(28.0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

}
