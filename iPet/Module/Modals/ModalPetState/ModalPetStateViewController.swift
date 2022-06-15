import UIKit

class ModalPetStateViewController: ViewController<ModalPetStateView> {

    private let petState: PetState
    
    init(petState: PetState) {
        self.petState = petState
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.viewForClose.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        
        configure()
    }
    
    private func configure() {
        mainView.titleLabel.text = petState.name
        mainView.subtitleLabel.text = petState.stateDescription
        
        if petState == .excellentBody {
            mainView.actionButton.backgroundColor = R.color.blueAccent()
            mainView.actionButton.setTitle("ОК", for: .normal)
            mainView.actionButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        } else {
            mainView.actionButton.backgroundColor = R.color.orangeAccent()
            mainView.actionButton.setTitle("Билетик в спортзал", for: .normal)
            // TODO: - Add action button target
        }
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
}
