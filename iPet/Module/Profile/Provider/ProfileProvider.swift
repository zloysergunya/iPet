import Foundation

class ProfileProvider {
   
    func uploadUserPhoto(photo: URL?, completion: @escaping(Result<String, Error>) -> Void) {
        UserAPI.userAvatarPost(photo: photo) { response, error in
            if let url = response?.url {
                completion(.success(url))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func userFollowersGet(completion: @escaping(Result<[User], ModelError>) -> Void) {
        UserAPI.userFollowersGet { user, error in
            if let user = user {
                completion(.success(user.items))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
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
