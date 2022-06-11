import Foundation
import Alamofire

class GeneralAPI {
    
    class func generalGet(completion: @escaping ((_ data: APIGeneralResponse?,_ error: ErrorResponse?) -> Void)) {
        generalGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    private class func generalGetWithRequestBuilder() -> RequestBuilder<APIGeneralResponse> {
        let path = "/general"
        let URLString = iPetAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<APIGeneralResponse>.Type = iPetAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func generalLvlAwardsGet(completion: @escaping ((_ data: APIGeneralResponse?,_ error: ErrorResponse?) -> Void)) {
        generalLvlAwardsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    private class func generalLvlAwardsGetWithRequestBuilder() -> RequestBuilder<APIGeneralResponse> {
        let path = "/general/lvl/awards"
        let URLString = iPetAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<APIGeneralResponse>.Type = iPetAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
}
