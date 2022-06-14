import Foundation

enum PetState: Int {
    case excellentBody
    case gained
    case inBody
    case chubby
    case swamFat
    
    var name: String {
        switch self {
        case .excellentBody: return "Отличная форма"
        case .gained: return "Поднабрал"
        case .inBody: return "В теле"
        case .chubby: return "Пухлый"
        case .swamFat: return "Заплыл"
        }
    }
    
    var stateDescription: String {
        switch self {
        case .excellentBody: return "Всё по плану: ты выполняешь ежедневную норму шагов, а значит у зверька нет лишнего веса"
        case .gained: return "Пора немного сбросить вес! Зверёк снова будет в отличной форме, если ты пройдёшь суммарно на 10% больше шагов в течение 7 дней"
        case .inBody: return "Ты ещё можешь всё исправить! Надо в течение 7 дней суммарно увеличить норму шагов на 15%, и тогда зверёк вернётся в лучшую форму"
        case .chubby: return "Не сдавайся! Если за 7 дней суммарно прибавишь норму шагов на 20%, твой любимец скажет тебе спасибо"
        case .swamFat: return "Придётся попотеть! Ты забыл про своего зверька, и он подсел на сериалы и фастфуд. Суммарно увеличь норму шагов на 30% в течение 7 дней, и зверёк забудет про Netflix."
        }
    }
    
}
