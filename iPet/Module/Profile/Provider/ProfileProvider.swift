import Foundation

class ProfileProvider {
    
    func updateMe( completion: @escaping(Result<User, Error>) -> Void) {
        UserAPI.userMeGet() { user, error in
            if let user = user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
}

