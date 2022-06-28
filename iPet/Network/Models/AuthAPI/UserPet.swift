import Foundation

struct UserPet: Codable {
    var name: String
    let pet: Pet
    let activeStatus: Int
    let petObesityLevel: Int
    let selectedAnimal: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case pet
        case activeStatus = "active_status"
        case petObesityLevel = "pet_obesity_level"
        case selectedAnimal = "selected_animal"
    }
}
