import Foundation

class FollowingProvider {
    
    var page: Int = 1

    func userFollowingGet(completion: @escaping(Result<[User], ModelError>) -> Void) {
        UserAPI.userFollowingGet { user, error in
            if let user = user {
                completion(.success(user.items))
            } else if let error = error {
                completion(.failure(ModelError(err: error)))
            } else {
                completion(.failure(ModelError()))
            }
        }
    }

//    func followUser(userId: Int, completion: @escaping(Result<OkResponse, ModelError>) -> Void) {
//        UserAPI.userUserIdFollowPost(userId: userId) { responce, error in
//            if let responce = responce {
//                completion(.success(responce))
//            } else if let error = error {
//                completion(.failure(ModelError(err: error)))
//            } else {
//                completion(.failure(ModelError()))
//            }
//        }
//    }
    
}
