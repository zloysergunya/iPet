import UIKit
import SnapKit

class MainActivityProgressView: UIView {
    
    let stepsProgressView = ActivityProgressView(color: .init(hex: 0xFF6C03))
    let goalProgressView = ActivityProgressView(color: .init(hex: 0x0090E1))
    let activityProgressView = ActivityProgressView(color: .init(hex: 0xFF6C03))
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 24.0
        
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(stepsProgressView)
        stackView.addArrangedSubview(goalProgressView)
        stackView.addArrangedSubview(activityProgressView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
