import GoogleSignIn

class SignInProvider {
    
    func signInWithGoogle(completion: @escaping(Result<GIDGoogleUser, Error>) -> Void) {
        guard let topViewController = Utils.getTopViewController() else {
            return
        }
        
        let clientID = "471967742267-qfcf0p6rl2grpm3noqd0hr1ve8hrr8he.apps.googleusercontent.com"
        let configuration = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: topViewController) { user, error in
            if let user = user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func authGooglePost(token: String, completion: @escaping(Result<AuthGoggleResponse, Error>) -> Void) {
        AuthAPI.authGooglePost(token: token) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
}
