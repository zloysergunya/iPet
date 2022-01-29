import UIKit
import AuthenticationServices

class SignInViewController: ViewController<SignInView> {
    
    private let provider = SignInProvider()
    private lazy var appleSignInService = AppleSignInService(viewController: self)
    private lazy var googleSignInService = GoogleSignInService(viewController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appleSignInService.output = self
        googleSignInService.output = self
        
        mainView.appleAuthButton.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
        mainView.googleAuthButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func signInWithApple() {
        appleSignInService.performRequest()
    }
    
    @objc private func signInWithGoogle() {
        googleSignInService.performRequest()
    }
    
    private func authGoogle(token: String) {
        provider.authGooglePost(token: token) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let authResponse):
                self.authorize(token: authResponse.token, currentUserId: authResponse.user.id)
                self.navigationController?.pushViewController(RegisterUserInputViewController(), animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func authApple(token: String) {
        provider.authApplePost(token: token) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let authResponse):
//                UserSettings.userReady = !authResponse.new
                self.authorize(token: authResponse.token, currentUserId: authResponse.user.id)
                
                let launchService: LaunchService? = ServiceLocator.getService()
                launchService?.selectViewController()
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }

    private func authorize(token: String, currentUserId: Int) {
        let authService: AuthService? = ServiceLocator.getService()
        authService?.authorize(with: token, currentUserId: currentUserId)
    }

}

// MARK: - AppleSignInServiceOutput
extension SignInViewController: AppleSignInServiceOutput {
    
    func appleSignIn(didFailWith error: Error) {
        //todo
    }
    
    func appleSignIn(didSucceedWith token: String) {
        authApple(token: token)
    }
        
}

// MARK: - GoogleSignInServiceOutput
extension SignInViewController: GoogleSignInServiceOutput {
    
    func googleSignIn(didFailWith error: Error) {
        // todo
    }
    
    func googleSignIn(didSucceedWith token: String) {
        authGoogle(token: token)
    }
    
}
