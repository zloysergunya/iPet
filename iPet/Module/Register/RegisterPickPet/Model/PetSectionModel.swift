import IGListDiffKit

class PetSectionModel {

    let pet: Pet
    var petAnimation: PetAnimation?
    var sample: Bool
    
    init(pet: Pet, petAnimation: PetAnimation? = nil, sample: Bool = false) {
        self.pet = pet
        self.petAnimation = petAnimation
        self.sample = sample
    }
    
}

// MARK: - ListDiffable
extension PetSectionModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return String(pet.id) as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.pet.id == pet.id
    }
    
}
