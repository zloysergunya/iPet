import Foundation

class ProfileSettingsProvider {
    
    func patchUser(userMe: UserMeRequest, completion: @escaping(Result<User, Error>) -> Void) {
        UserAPI.userMePatch(userMe: userMe) { user, error in
            if let user = user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func checkAvailabilityNickname(_ username: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        UserAPI.userCheckUsernamePost(username: UserCheckUsernameRequest(username: username)) { used, error in
            if let used = used?.used {
                completion(.success(used))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func translitName(_ name: String, completion: @escaping(Result<String, Error>) -> Void) {
        UserAPI.userUsernameTranslitPost(name: UserUsernameTranslitRequest(name: name)) { translitUsername, error in
            if let username = translitUsername?.username {
                completion(.success(username))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func getPets(free: Bool? = nil, myPets: Bool? = nil, completion: @escaping(Result<[Pet], Error>) -> Void) {
        PetAPI.petGet(free: free, myPets: myPets) { pets, error in
            if let pets = pets?.items {
                completion(.success(pets))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func updateUserPet(userPetId: Int, userPetUserPetIdRequest: UserPetUserPetIdRequest, completion: @escaping(Result<OkResponse, Error>) -> Void) {
        UserAPI.userPetUserPetIdPatch(userPetId: userPetId, userPetUserPetIdRequest: userPetUserPetIdRequest) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func choicePet(petId: Int, completion: @escaping(Result<OkResponse, Error>) -> Void) {
        UserAPI.userPetChoicePetIdPatch(petId: petId) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }

    func changePetName(petId: Int, name: String, completion: @escaping(Result<OkResponse, Error>) -> Void) {
        UserAPI.userPetUserPetIdPatch(userPetId: petId, userPetUserPetIdRequest: UserPetUserPetIdRequest(name: name)) { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func uploadUserPhoto(photo: URL?, completion: @escaping(Result<String, Error>) -> Void) {
        UserAPI.userAvatarPost(photo: photo) { response, error in
            if let url = response?.url {
                completion(.success(url))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
}
