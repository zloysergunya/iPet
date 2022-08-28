import Foundation
import IGListDiffKit

class FollowingListSectionModel {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
}

// MARK: - ListDiffable
extension FollowingListSectionModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return String(user.id) as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        return object.user == user
    }
}
