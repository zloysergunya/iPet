import Foundation

struct Award: Codable {
    let position: Int
    let completed: Bool
    let name, awardDescription: String
    let awardLeft, passes: Int?

    enum CodingKeys: String, CodingKey {
        case position, completed, name
        case awardDescription = "description"
        case awardLeft = "left"
        case passes
    }
}
