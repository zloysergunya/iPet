import UIKit

class PlugPopUpViewController: ViewController<PlugPopUpView> {
        
    init(image: UIImage?, title: String, text: String) {
        super.init(nibName: nil, bundle: nil)
        
        mainView.imageView.image = image
        mainView.titleLabel.text = title
        mainView.subtitleLabel.text = text
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.viewForClose.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        mainView.actionButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
}
