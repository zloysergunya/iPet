import Foundation

struct UserSearchRequest: Codable {
    let username: String
    let param: UserSearchRequestParam
    var limit: Int = 25
    let offset: Int
}

enum UserSearchRequestParam: String, Codable {
    case all, following, followers
}
