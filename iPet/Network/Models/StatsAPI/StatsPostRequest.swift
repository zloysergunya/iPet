import Foundation

struct StatsPostRequest: Codable {
    let date: Int64
    let calories: Int
    let kilometers: Double
    let steps: Int
}
