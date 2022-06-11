import Foundation

class SignInProvider {
    
    func authGooglePost(token: String, completion: @escaping(Result<AuthGoggleResponse, Error>) -> Void) {
        AuthAPI.authGooglePost(token: token) { response, error in
            if let response = response {
                UserSettings.token = response.token
                UserSettings.user = response.user
                completion(.success(response))
            } else if let error = error {
                log.error(ModelError(err: error).message())
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func authApplePost(token: String, completion: @escaping(Result<AuthGoggleResponse, Error>) -> Void) {
        AuthAPI.authApplePost(token: token) { response, error in
            if let response = response {
                UserSettings.token = response.token
                UserSettings.user = response.user
                completion(.success(response))
            } else if let error = error {
                log.error(ModelError(err: error).message())
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
}
