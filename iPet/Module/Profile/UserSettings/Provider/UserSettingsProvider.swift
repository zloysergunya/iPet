import Foundation

class UserSettingsProvider {
    
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
    
    func updateUserPet(userPetId: Int, userPetUserPetIdRequest: UserPetUserPetIdRequest, completion: @escaping(Result<OkResponse, ModelError>) -> Void) {
        UserAPI.userPetUserPetIdPatch(userPetId: userPetId, userPetUserPetIdRequest: userPetUserPetIdRequest) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }
    
    func choicePet(petId: Int, completion: @escaping(Result<OkResponse, ModelError>) -> Void) {
        UserAPI.userPetChoicePetIdPatch(petId: petId) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }

    func changePetName(petId: Int, name: String, completion: @escaping(Result<OkResponse, ModelError>) -> Void) {
        UserAPI.userPetUserPetIdPatch(userPetId: petId, userPetUserPetIdRequest: UserPetUserPetIdRequest(name: name)) { response, error in
            if let response = response {
                completion(.success(response))
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
    
}
