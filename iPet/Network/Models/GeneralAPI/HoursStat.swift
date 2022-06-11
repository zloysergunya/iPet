import Foundation

struct HoursStat: Codable {
    let activityMinutes: Int
    let calories: Int
    let dateCreate: Int
    let day: Int
    let id: Int
    let kilometers: Double
    let steps: Int
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case activityMinutes = "activity_minutes"
        case calories
        case dateCreate = "date_create"
        case day
        case id
        case kilometers
        case steps
        case userID = "user_id"
    }
}
