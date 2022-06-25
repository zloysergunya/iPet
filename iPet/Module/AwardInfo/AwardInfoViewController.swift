import UIKit

class AwardInfoViewController: ViewController<AwardInfoView> {
    
    private let award: Award
    
    init(award: Award) {
        self.award = award
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
        mainView.actionButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        configure()
    }
    
    private func configure() {
        mainView.imageView.image = award.completed ? R.image.completedAchivment118() : R.image.missedAchivment118()
        mainView.titleLabel.text = award.name
        mainView.subtitleLabel.text = award.awardDescription
        
        mainView.progressLabel.isHidden = award.completed
        if !award.completed, let passes = award.passes, let awardLeft = award.awardLeft {
            mainView.progressLabel.text = "Выполнено\n\(passes) из \(passes + awardLeft)"
        }
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
}
