import Foundation

struct UserMeResponce: Codable {
//    let obesityProgress: ObesityProgress
    let stats: Stats
    let user: User

    enum CodingKeys: String, CodingKey {
//        case obesityProgress = "obesity_progress"
        case stats, user
    }
}
