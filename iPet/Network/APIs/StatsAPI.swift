import Foundation
import Alamofire

class StatsAPI {
    
    class func statsPost(statsPostRequest: StatsPostRequest, completion: @escaping ((_ data: OkResponse?,_ error: ErrorResponse?) -> Void)) {
        statsPostWithRequestBuilder(statsPostRequest: statsPostRequest).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    private class func statsPostWithRequestBuilder(statsPostRequest: StatsPostRequest) -> RequestBuilder<OkResponse> {
        let path = "/stats"
        let URLString = iPetAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: statsPostRequest)
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OkResponse>.Type = iPetAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
}
