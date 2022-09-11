import Foundation

class ProfileSettingsProvider {
    
    func updateMe( completion: @escaping(Result<UserMeResponce, Error>) -> Void) {
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
