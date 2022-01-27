import Foundation
import GoogleSignIn

protocol GoogleSignInServiceInput {
    func performRequest()
}

protocol GoogleSignInServiceOutput: AnyObject {
    func googleSignIn(didFailWith error: Error)
    func googleSignIn(didSucceedWith token: String)
}

class GoogleSignInService: NSObject {
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }
    
    weak var output: GoogleSignInServiceOutput?
    
    private var viewController: UIViewController
    private let clientID = "471967742267-qfcf0p6rl2grpm3noqd0hr1ve8hrr8he.apps.googleusercontent.com"
}

// MARK: - AppleSignInServiceInput
extension GoogleSignInService: GoogleSignInServiceInput {
    
    func performRequest() {
        let configuration = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: viewController) { [weak self] user, error in
            if let user = user {
                self?.output?.googleSignIn(didSucceedWith: user.authentication.accessToken)
            } else if let error = error {
                self?.output?.googleSignIn(didFailWith: error)
            } else {
                self?.output?.googleSignIn(didFailWith: NSError())
            }
        }
    }
    
}
