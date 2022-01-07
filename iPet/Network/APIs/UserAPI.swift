import Foundation
import Alamofire

class UserAPI {
    
    class func userCheckUsernamePost(username: UserCheckUsernameRequest, completion: @escaping ((_ data: UserCheckUsernameResponse?,_ error: ErrorResponse?) -> Void)) {
        userCheckUsernamePostWithRequestBuilder(username: username).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    private class func userCheckUsernamePostWithRequestBuilder(username: UserCheckUsernameRequest) -> RequestBuilder<UserCheckUsernameResponse> {
        let path = "/user/check/username"
        let URLString = iPetAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: username)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<UserCheckUsernameResponse>.Type = iPetAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    class func userUsernameTranslitPost(name: UserUsernameTranslitRequest, completion: @escaping ((_ data: UserUsernameTranslitResponse?,_ error: ErrorResponse?) -> Void)) {
        userUsernameTranslitPostWithRequestBuilder(name: name).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    private class func userUsernameTranslitPostWithRequestBuilder(name: UserUsernameTranslitRequest) -> RequestBuilder<UserUsernameTranslitResponse> {
        let path = "/user/username/translit"
        let URLString = iPetAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: name)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<UserUsernameTranslitResponse>.Type = iPetAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
    class func userMePatch(userMe: UserMeRequest, completion: @escaping ((_ data: User?,_ error: ErrorResponse?) -> Void)) {
        userMePatchWithRequestBuilder(userMe: userMe).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    private class func userMePatchWithRequestBuilder(userMe: UserMeRequest) -> RequestBuilder<User> {
        let path = "/user/me"
        let URLString = iPetAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: userMe)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<User>.Type = iPetAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PATCH", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
}
