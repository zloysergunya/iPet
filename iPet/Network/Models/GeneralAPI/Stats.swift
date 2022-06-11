import Foundation

struct Stats: Codable {
    let activityMinutes: Int
    let activityMinutesGoal: Int
    let calories: Int
    let dateCreate: Int
    let dayActivity: Int
    let hoursStats: [HoursStat]?
    let id: Int
    let kilometers: Double
    let steps: Int
    let stepsGoal: Int
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case activityMinutes = "activity_minutes"
        case activityMinutesGoal = "activity_minutes_goal"
        case calories
        case dateCreate = "date_create"
        case dayActivity = "day_activity"
        case hoursStats = "hours_stats"
        case id
        case kilometers
        case steps
        case stepsGoal = "steps_goal"
        case userID = "user_id"
    }
}
