import Foundation
import Lottie

class GeneralProvider {
    
    func general(completion: @escaping(Result<Stats, ModelError>) -> Void) {
        GeneralAPI.generalGet { response, error in
            if let response = response {
                UserSettings.user = response.user
                completion(.success(response.stats))
            } else if let error = error {
                log.error(ModelError(err: error).message())
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func generalLvlAwards(completion: @escaping(Result<Stats, ModelError>) -> Void) {
        GeneralAPI.generalLvlAwardsGet { response, error in
            if let response = response {
                UserSettings.user = response.user
                completion(.success(response.stats))
            } else if let error = error {
                log.error(ModelError(err: error).message())
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func updateConfig(completion: @escaping(Result<OkResponse, ModelError>) -> Void) {
        let utc = TimeZone.current.secondsFromGMT() / 3600
        let userConfig = UserConfig(utc: "\(utc)")
        UserAPI.userConfigPatch(userConfig: userConfig) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                log.error(ModelError(err: error).message())
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func downloadPets(completion: @escaping(Result<[PetAnimation], ModelError>) -> Void) {
        PetAPI.petDownloads { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                log.error(ModelError(err: error).message())
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func cacheAnimations(_ animations: [PetAnimation]) {
        animations.forEach { petAnimation in
            cacheAnimation(stringURL: petAnimation.animations.base, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.blink, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.happy, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.leftRight, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.registration, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.scratch, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.tap, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.yawn, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.heart, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.sleeping, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.tears, state: petAnimation.state)
            cacheAnimation(stringURL: petAnimation.animations.moveTears, state: petAnimation.state)
        }
    }
    
    private func cacheAnimation(stringURL: String?, state: Int) {
        if let url = URL(string: stringURL?.replacingOccurrences(of: "pet_state", with: "\(state)") ?? "") {
            Animation.loadedFrom(url: url, closure: { _ in }, animationCache: LRUAnimationCache.sharedCache)
        }
    }
    
}
