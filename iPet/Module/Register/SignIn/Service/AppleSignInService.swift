import Foundation
import AuthenticationServices

protocol AppleSignInServiceInput {
    func performRequest()
}

protocol AppleSignInServiceOutput: AnyObject {
    func appleSignIn(didFailWith error: Error)
    func appleSignIn(didSucceedWith token: String)
}

class AppleSignInService: NSObject {
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }
    
    weak var output: AppleSignInServiceOutput?
    
    private var viewController: UIViewController
    private let appleIDProvider = ASAuthorizationAppleIDProvider()
    
}

// MARK: - AppleSignInServiceInput
extension AppleSignInService: AppleSignInServiceInput {
    
    func performRequest() {
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleSignInService: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = appleIDCredential.authorizationCode,
              let codeStr = String(data: code, encoding: .utf8)
        else {
            return
        }
        
        output?.appleSignIn(didSucceedWith: codeStr)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let error = error as? ASAuthorizationError {
            print(error)
        } else {
            print("unknown error \( error)")
        }
        
        output?.appleSignIn(didFailWith: error)
    }
    
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleSignInService: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        viewController.view.window ?? .init(frame: UIScreen.main.bounds)
    }
    
}
