import UIKit
import IGListKit

class FollowingListViewController: ViewController<FollowingListView> {
    
    private let provider = FollowingProvider()
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    private var loadingState: LoadingState = .none
    private var objects: [FollowingListSectionModel] = []
    private var query: String = ""
    private var pendingRequestWorkItem: DispatchWorkItem?

    
    init() {
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
            objects.append(contentsOf: users.map({ FollowingListSectionModel(user: $0) }))
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
        provider.userFollowingGet() { [weak self] result in
            self?.handleResult(flush: flush, result: result)
        }
    }
    
    @objc private func globalSearchButtonPressed() {
        
    }
}

// MARK: - UITextFieldDelegate
extension FollowingListViewController: UITextFieldDelegate {
    
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
extension FollowingListViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = FollowingListSectionController()
        sectionController.delegate = self

        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return EmptyView()
    }
    
}

// MARK: - UserListSectionControllerDelegate
extension FollowingListViewController: FollowingListSectionControllerDelegate {
    func followersListSectionController(didSelect user: User) {
        navigationController?.pushViewController(FriendProfileViewController(user: user), animated: true)
    }

    func followerListSectionController(willDisplay cell: UICollectionViewCell, at section: Int) {
        if section + 1 >= objects.count - Constants.pageLimit / 2, loadingState != .loading, provider.page != -1 {
            load(flush: false)
        }
    }

}
