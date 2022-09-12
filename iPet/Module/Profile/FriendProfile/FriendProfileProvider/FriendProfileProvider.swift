import Foundation

class FriendProfileProvider {
    
    func userFollowingGet(completion: @escaping(Result<[User], ModelError>) -> Void) {
        UserAPI.userFollowingGet { user, error in
            if let user = user {
                completion(.success(user.items))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
}


