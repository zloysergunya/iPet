import Foundation

struct User: Codable {

    var id: Int
    var name: String
    var username: String
    var gender: String
    var stepsCount: Int
    var coins: Int
    var height: Int
    var age: Int
    var weight: Int
    var chillDay: Int
    var totalDistance: Double
    var inviteLink: String
    var countInvited: Int
    var countFollowers: Int
    var countFollowing: Int
    var pet: UserPet?
    var lvlActivity: Int
    var avatarURL: String
    var lastVisit: Int
    var follow: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case gender
        case stepsCount = "steps_count"
        case coins
        case height
        case age
        case weight
        case chillDay = "chill_day"
        case totalDistance = "total_distance"
        case inviteLink = "invite_link"
        case countInvited = "count_invited"
        case countFollowers = "count_followers"
        case countFollowing = "count_following"
        case pet
        case lvlActivity = "lvl_activity"
        case avatarURL = "avatar_url"
        case lastVisit = "last_visit"
        case follow
    }

}

extension User: Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
}
