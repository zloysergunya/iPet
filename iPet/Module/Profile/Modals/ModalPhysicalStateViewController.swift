import UIKit

class ModalPhysicalStateViewController: ViewController<ModalPhysicalStateView> {

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
        mainView.thumbView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        configure()
    }
    
    private func configure() {
        mainView.titleLabel.text = petState.name
        mainView.subtitleLabel.text = petState.stateDescription
        
        mainView.actionButton.setTitle("OK", for: .normal)
        mainView.actionButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
}
