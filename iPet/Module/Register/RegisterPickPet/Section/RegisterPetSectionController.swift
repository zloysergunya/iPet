import IGListKit
import Lottie

protocol RegisterPickPetSectionControllerDelegate: AnyObject {
    func registerPickPetSectionController(didSelect sectionModel: PetSectionModel, at section: Int)
}

class RegisterPickPetSectionController: ListSectionController {
    
    private var sectionModel: PetSectionModel!
    
    weak var delegate: RegisterPickPetSectionControllerDelegate?
    
    override init() {
        super.init()
        
        minimumLineSpacing = 12.0
        minimumInteritemSpacing = 12.0
    }
        
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 240.0, height: 240.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: RegisterPickPetCell.self, for: self, at: index)
        
        return configure(cell: cell)
    }
    
    private func configure(cell: RegisterPickPetCell) -> RegisterPickPetCell {
        cell.petNameLabel.text = sectionModel.pet.pet
        
        if let urlString = sectionModel.petAnimation?.animations.registration?.replacingOccurrences(of: "pet_state", with: "\(1)"),
           let url = URL(string: urlString) {
            Animation.loadedFrom(url: url, closure: { animation in
                cell.petAnimationView.animation = animation
                cell.petAnimationView.play()
            }, animationCache: nil)
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is PetSectionModel)
        sectionModel = object as? PetSectionModel
    }
    
    override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)
        
        delegate?.registerPickPetSectionController(didSelect: sectionModel, at: section)
    }
}
