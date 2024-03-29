import UIKit

class StateView: UIView {
    
    let stateCount: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = .init(hex: 0x222323)
        
        return label
    }()
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 12.0)
        label.textColor = R.color.mainGray()
        label.numberOfLines = 2
        
        return label
    }()
    
    private(set) lazy var stateStackView = UIStackView(views: [stateCount, stateLabel], alignment: .leading)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(stateStackView)
        
        stateStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
