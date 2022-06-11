import Foundation
import UIKit

enum ActiveStatus: Int {
    case activeAsPossible
    case active
    case moderatelyActive
    case sedentary
    case heavyOnTheRise
    
    var description: String {
        switch self {
        case .activeAsPossible: return "Максимально активный"
        case .active: return "Активный"
        case .moderatelyActive: return "Умеренно активный"
        case .sedentary: return "Малоподвижный"
        case .heavyOnTheRise: return "Тяжелый на подъем"
        }
    }
    
    var colors: [UIColor] {
        switch self {
        case .activeAsPossible: return [R.color.activityGreenColor() ?? .green, .white]
        case .active: return [R.color.activityGreenColor() ?? .green, .white]
        case .moderatelyActive: return [R.color.activityOrangeColor() ?? .orange, .white]
        case .sedentary: return [R.color.activityOrangeColor() ?? .orange, .white]
        case .heavyOnTheRise: return [R.color.activityRedColor() ?? .red, .white]
        }
    }
    
}
