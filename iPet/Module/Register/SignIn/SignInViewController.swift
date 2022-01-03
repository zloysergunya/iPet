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
                print(authGoogleResponse.token)
                
            case .failure(let error):
                print("Google authorization failed with error: ", error.localizedDescription)
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
        
        let email = appleIDCredential.email
        let firstName = appleIDCredential.fullName?.givenName
        let lastName = appleIDCredential.fullName?.familyName
        // создать или залогиниться в своей системе с помощью кода авторизации codeStr
        
        print(email, firstName, lastName, codeStr)
        navigationController?.pushViewController(RegisterUserInputViewController(), animated: true)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple sign in failed with error: ", error.localizedDescription)
    }
    
}
