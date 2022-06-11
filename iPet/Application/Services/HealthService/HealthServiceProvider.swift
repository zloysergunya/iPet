import Foundation

class HealthServiceProvider {
    
    func sendUserActivity(statsPostRequest: StatsPostRequest, completion: @escaping(Result<OkResponse, ModelError>) -> Void) {
        StatsAPI.statsPost(statsPostRequest: statsPostRequest) { response, error in
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
    
}
