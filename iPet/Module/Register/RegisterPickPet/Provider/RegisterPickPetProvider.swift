import Foundation

class RegisterPickPetProvider {
    
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
    
    func downloadPets(completion: @escaping(Result<[PetAnimation], Error>) -> Void) {
        PetAPI.petDownloads { response, error in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(NSError()))
            }
        }
    }
    
    func petRandomName(completion: @escaping(Result<String, Error>) -> Void) {
        PetAPI.petRandomName { response, error in
            if let name = response?.name {
                completion(.success(name))
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
    
}
