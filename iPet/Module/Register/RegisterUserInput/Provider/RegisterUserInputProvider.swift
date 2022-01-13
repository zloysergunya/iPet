import Foundation

class RegisterUserInputProvider {
    
    func checkAvailabilityNickname(_ username: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        UserAPI.userCheckUsernamePost(username: UserCheckUsernameRequest(username: username)) { used, error in
            if let used = used?.used {
                completion(.success(used))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func translitName(_ name: String, completion: @escaping(Result<String, Error>) -> Void) {
        UserAPI.userUsernameTranslitPost(name: UserUsernameTranslitRequest(name: name)) { translitUsername, error in
            if let username = translitUsername?.username {
                completion(.success(username))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func patchUser(userMe: UserMeRequest, completion: @escaping(Result<User, Error>) -> Void) {
        UserAPI.userMePatch(userMe: userMe) { user, error in
            if let user = user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
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
    
}
