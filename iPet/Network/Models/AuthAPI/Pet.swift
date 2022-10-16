import Foundation

struct Pet: Codable {
    var description: String
    var free: Bool
    var id: Int
    var pet: String
    var staticPhoto: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case free
        case id
        case pet
        case staticPhoto = "static_photo"
    }
}
