import IGListKit
import UIKit

protocol FollowersListSectionControllerDelegate: AnyObject {
    func followersListSectionController(didSelect user: User)
    func followerListSectionController(willDisplay cell: UICollectionViewCell, at section: Int)
}

class FollowersListSectionController: ListSectionController {
    
    private let provider = FollowersListProvider()
    
    weak var delegate: FollowersListSectionControllerDelegate?
    
    private var sectionModel: FollowerListSectionModel!
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 16.0, right: 0.0)
        minimumLineSpacing = 8.0
        
        displayDelegate = self
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let inset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        return CGSize(width: collectionContext!.containerSize.width, height: 50.0).inset(by: inset)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: UserCell.self, for: self, at: index)
        
        return configure(cell: cell)
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is FollowerListSectionModel)
        sectionModel = object as? FollowerListSectionModel
    }
    
    override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)
        
        delegate?.followersListSectionController(didSelect: sectionModel.user)
    }
    
    private func configure(cell: UserCell) -> UICollectionViewCell {

        let username = sectionModel.user.username
        cell.username.text = username
        
        let userPetName = sectionModel.user.pet?.name
        cell.userPetName.text = userPetName
        
        ImageLoader.setImage(url: sectionModel.user.avatarURL, imageView: cell.userImage)
        
        let userStatus = sectionModel.user.follow ? R.image.removeUser() : R.image.addUser()
        cell.userStatus.setImage(userStatus, for: .normal)
        
        return cell
    }
    
}

// MARK: - ListDisplayDelegate
extension FollowersListSectionController: ListDisplayDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {}
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {}
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        delegate?.followerListSectionController(willDisplay: cell, at: section)
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {}
}
