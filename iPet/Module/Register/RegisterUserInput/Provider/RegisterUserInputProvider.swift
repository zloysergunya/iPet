import Foundation
import Lottie

class RegisterUserInputProvider {
    
    func checkAvailabilityNickname(_ username: String, completion: @escaping(Result<Bool, ModelError>) -> Void) {
        UserAPI.userCheckUsernamePost(username: UserCheckUsernameRequest(username: username)) { used, error in
            if let used = used?.used {
                completion(.success(used))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func translitName(_ name: String, completion: @escaping(Result<String, ModelError>) -> Void) {
        UserAPI.userUsernameTranslitPost(name: UserUsernameTranslitRequest(name: name)) { translitUsername, error in
            if let username = translitUsername?.username {
                completion(.success(username))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func patchUser(userMe: UserMeRequest, completion: @escaping(Result<User, ModelError>) -> Void) {
        UserAPI.userMePatch(userMe: userMe) { user, error in
            if let user = user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func uploadUserPhoto(photo: URL?, completion: @escaping(Result<String, ModelError>) -> Void) {
        UserAPI.userAvatarPost(photo: photo) { response, error in
            if let url = response?.url {
                completion(.success(url))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func getPets(free: Bool? = nil, myPets: Bool? = nil, completion: @escaping(Result<[Pet], ModelError>) -> Void) {
        PetAPI.petGet(free: free, myPets: myPets) { pets, error in
            if let pets = pets?.items {
                completion(.success(pets))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func downloadPets(completion: @escaping(Result<[PetAnimation], ModelError>) -> Void) {
        PetAPI.petDownloads { response, error in
            if let response = response {
                response.forEach { petAnimation in
                    if let urlString = petAnimation.animations.registration?.replacingOccurrences(of: "pet_state", with: "\(1)"),
                       let url = URL(string: urlString) {
                        Animation.loadedFrom(url: url, closure: { _ in }, animationCache: LRUAnimationCache.sharedCache)
                    }
                }
                
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
}
