import Foundation

fileprivate struct DecodableError: Codable {
    let desc: String
    let code: String
}

struct ModelError: Error {
    var err: ErrorResponse?
    var text: String?
    
    @Autowired
    private var authService: AuthService?
    
    init() {
        
    }
    
    init(err: ErrorResponse?) {
        self.err = err
    }
    
    init(text: String) {
        self.text = text
    }

    func message() -> String {
        if let text = text {
            return text
        }
        
        if case .error(let status, let data?, let error) = err {
            if let decodeError = CodableHelper.decode(DecodableError.self, from: data).decodableObj {
                return decodeError.desc
            }
            
            log.error("Error \(status): \(error.localizedDescription)")
            
            let message = "Error \(status): "
            switch status {
            case 401:
                authService?.deauthorize()                
                return message + "Ошибка авторизации. Пожалуйста, войдите в свой аккаунт заново"
                
            case 403: return message + "Доступ запрещён"
            case 404: return message + "Данные не найдены"
            case 400...499: return message + "Ошибка в запросе на сервер"
            case 500...599: return message + "Сервер временно недоступен. Попробуйте позднее"
            case 1000: return message + "Проверьте доступ к интернету"
            default: return message + "Неизвестная ошибка (не удалось декодировать ошибку)"
            }
            
            return "Unknown error (failed to decode error)"
        }
        
        return "Failed to decode server response"
    }

    var localizedDescription: String {
        return message()
    }
    
}
