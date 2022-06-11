import Foundation

enum PetState: Int {
    case excellentBody
    case gained
    case inBody
    case chubby
    case swamFat
    
    var description: String {
        switch self {
        case .excellentBody: return "отличная форма"
        case .gained: return "поднабрал"
        case .inBody: return "в теле"
        case .chubby: return "пухлый"
        case .swamFat: return "заплыл"
        }
    }
    
}
