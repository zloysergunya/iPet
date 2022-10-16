import Foundation

struct Pet: Codable {
    var description: String = ""
    var free: Bool = true
    var id: Int = 0
    var pet: String = ""
    var staticPhoto: String = ""
    
    enum CodingKeys: String, CodingKey {
        case staticPhoto = "static_photo"
    }
}
