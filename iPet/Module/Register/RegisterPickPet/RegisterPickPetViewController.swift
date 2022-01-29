import UIKit
import IGListKit

class RegisterPickPetViewController: ViewController<RegisterPickPetView> {
    
    private let provider = RegisterPickPetProvider()
    
    private var loadingState: LoadingState = .none
    private var pets: [Pet] = UserSettings.pets ?? []
    private var petAnimations: [PetAnimation] = UserSettings.petAnimations ?? []
    private var objects: [PetSectionModel] = []
    private var selectedPet: Pet?
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.generatePetNameButton.addTarget(self, action: #selector(generatePetRandomName), for: .touchUpInside)
        mainView.continueButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        updateObjects()
        getPets()
        hideKeyboardWhenTappedAround()
        bindEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func bindEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getPets() {
        provider.getPets(free: true) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let pets):
                UserSettings.pets = pets
                self.pets = pets
                self.selectedPet = pets.first
                self.downloadPets()
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func downloadPets() {
        provider.downloadPets { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let petAnimations):
                UserSettings.petAnimations = petAnimations
                self.petAnimations = petAnimations
                
                self.updateObjects()
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func updateObjects() {
        objects.removeAll()
        pets.forEach { pet in
            let petAnimation = self.petAnimations.first(where: { $0.id == pet.id })
            objects.append(PetSectionModel(pet: pet, petAnimation: petAnimation))
        }
        
        adapter.performUpdates(animated: true)
    }
    
    private func petRandomName() {
        provider.petRandomName { [weak self] result in
            switch result {
            case .success(let name):
                self?.mainView.petNameInputView.textField.text = name
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func choicePet() {
        guard let petId = selectedPet?.id else {
            return
        }
        
        provider.choicePet(petId: petId) { [weak self] result in
            switch result {
            case .success:
                self?.changePetName()
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func changePetName() {
        guard let petId = selectedPet?.id else {
            return
        }
        
        guard let name = mainView.petNameInputView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            Animations.shake(view: mainView.petNameInputView)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
            return
        }
        
        provider.changePetName(petId: petId, name: name) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.pushViewController(RegisterStepsInputViewController(), animated: true)
                
            case .failure(let error):
                if let error = error as? ModelError {
                    print(error.message())
                }
            }
        }
    }
    
    private func centeredIndexPath() -> IndexPath? {
        guard let point = mainView.collectionView.superview?.convert(mainView.collectionView.center, to: mainView.collectionView) else {
            return nil
        }
        
        return mainView.collectionView.indexPathForItem(at: point)
    }
    
    @objc private func generatePetRandomName(sender: UIButton) {
        Animations.shake(view: sender)
        
        petRandomName()
    }
    
    @objc private func save(_ sender: UIButton) {
        Animations.press(view: sender)
        
        choicePet()
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard
            let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        else {
            return
        }

        let keyBoardHeight = keyboardRect.height
        
        mainView.updateButtonBottomConstraint(duration: duration, -keyBoardHeight - 12.0)
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        
        mainView.updateButtonBottomConstraint(duration: duration)
    }
    
}

// MARK: - ListAdapterDataSource
extension RegisterPickPetViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = RegisterPickPetSectionController()
        sectionController.delegate = self
        
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

// MARK: - RegisterPickPetSectionControllerDelegate
extension RegisterPickPetViewController: RegisterPickPetSectionControllerDelegate {
    
    func registerPickPetSectionController(didSelect sectionModel: PetSectionModel, at section: Int) {
        selectedPet = sectionModel.pet
        
        mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: section), at: .centeredHorizontally, animated: true)
    }
    
}

// MARK: - ScrollViewDelegate
extension RegisterPickPetViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = centeredIndexPath(), objects.count > indexPath.section {
            selectedPet = objects[indexPath.section].pet
        }
    }

}
