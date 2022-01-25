import UIKit
import AuthenticationServices

class SignInViewController: ViewController<SignInView> {
    
    private let provider = SignInProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.appleAuthButton.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
        mainView.googleAuthButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    @objc private func signInWithGoogle() {
        provider.signInWithGoogle { [weak self] result in
            switch result {
            case .success(let googleUser):
                self?.authGoogle(token: googleUser.authentication.accessToken)
                
            case .failure(let error):
                print("Google sign in failed with error: ", error.localizedDescription)
            }
        }
    }
    
    private func authGoogle(token: String) {
        provider.authGooglePost(token: token) { [weak self] result in
            switch result {
            case .success(let authGoogleResponse):
                print(authGoogleResponse)
                iPetAPI.customHeaders["X-Token"] = authGoogleResponse.token
                self?.navigationController?.pushViewController(RegisterUserInputViewController(), animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func authApple(token: String) {
        provider.authApplePost(token: token) { [weak self] result in
            switch result {
            case .success(let authGoogleResponse):
                print(authGoogleResponse)
                iPetAPI.customHeaders["X-Token"] = authGoogleResponse.token
                self?.navigationController?.pushViewController(RegisterUserInputViewController(), animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }


}

// MARK: - ASAuthorizationControllerDelegate
extension SignInViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = appleIDCredential.authorizationCode,
              let codeStr = String(data: code, encoding: .utf8)
        else {
            return
        }
        
        authApple(token: codeStr)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple sign in failed with error: ", error.localizedDescription)
    }
    
}
