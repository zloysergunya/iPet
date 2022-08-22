import UIKit
import IGListKit

class FollowersListViewController: ViewController<FollowersListView> {
    
    private let isGLobalList: Bool
    private let provider = FollowersListProvider()
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    private var loadingState: LoadingState = .none
    private var objects: [FollowerListSectionModel] = []
    private var query: String = ""
    private var pendingRequestWorkItem: DispatchWorkItem?

    
    init(isGlobalList: Bool) {
        self.isGLobalList = isGlobalList
        super.init(nibName: nil, bundle: nil)
        
        title = "Подписчики"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        
        mainView.globalSearchButton.addTarget(self, action: #selector(globalSearchButtonPressed), for: .touchUpInside)
        
        mainView.searchBar.delegate = self
        mainView.backgroundColor = R.color.background()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        load(flush: true)
    }
    
    private func handleResult(flush: Bool, result: Result<[User], ModelError>) {
        mainView.collectionView.refreshControl?.endRefreshing()
        
        switch result {
        case .success(let users):
            if flush {
                objects.removeAll()
            }
            
            // Пример загрузки коллекции
            mainView.stackView.arrangedSubviews.forEach({  $0.removeFromSuperview()  })
            users.prefix(5).forEach { user in
                let imageView = UIImageView()
                
                ImageLoader.setImage(url: user.avatarURL, imageView: imageView)
                mainView.stackView.addArrangedSubview(imageView)
            }
            //
            
            objects.append(contentsOf: users.map({ FollowerListSectionModel(user: $0) }))
            loadingState = .loaded
        case .failure(let error):
            showError(text: error.localizedDescription)
            loadingState = .failed
        }
        
        adapter.performUpdates(animated: true)
    }

    // Отключение возможности одновременных загрузок
    private func load(flush: Bool) {
        guard loadingState != .loading else {
            return
        }
        loadingState = .loading
        
        if flush {
            provider.page = 1
        }
        loadFriends(flush: flush)
    }
    
    private func loadFriends(flush: Bool) {
        provider.userFollowersGet() { [weak self] result in
            self?.handleResult(flush: flush, result: result)
        }
    }
    
    @objc private func globalSearchButtonPressed() {
        
    }
}

// MARK: - UITextFieldDelegate
extension FollowersListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        guard query != replacedText.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return false
        }

        pendingRequestWorkItem?.cancel()

        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else {
                return
            }

            if replacedText.isEmpty {
                self.query = ""
            } else {
                self.query = replacedText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            self.load(flush: true)
        }

        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)

        return true
    }
}

// MARK: - ListAdapterDataSource
extension FollowersListViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = FollowersListSectionController()
        sectionController.delegate = self

        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return EmptyView()
    }
    
}

// MARK: - UserListSectionControllerDelegate
extension FollowersListViewController: FollowersListSectionControllerDelegate {
    func followersListSectionController(didSelect user: User) {
        navigationController?.pushViewController(ProfileViewController(user: user), animated: true)
    }

    func followerListSectionController(willDisplay cell: UICollectionViewCell, at section: Int) {
        if section + 1 >= objects.count - Constants.pageLimit / 2, loadingState != .loading, provider.page != -1 {
            load(flush: false)
        }
    }

}
