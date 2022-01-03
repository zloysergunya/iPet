import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let emailVerified: Bool
    let gender: String
    let stepsCount: Int
    let coins: Int
    let height: Int
    let age: Int
    let weight, chillDay: Int
    let inviteLink: String
    let countInvited: Int
    let countFollowers: Int
    let countFollowing: Int
    let pet: Pet?
    let lvlActivity: Int
    let avatarURL: String
    let lastVisit: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case emailVerified = "email_verified"
        case gender
        case stepsCount = "steps_count"
        case coins
        case height
        case age
        case weight
        case chillDay = "chill_day"
        case inviteLink = "invite_link"
        case countInvited = "count_invited"
        case countFollowers = "count_followers"
        case countFollowing = "count_following"
        case pet
        case lvlActivity = "lvl_activity"
        case avatarURL = "avatar_url"
        case lastVisit = "last_visit"
    }
}
