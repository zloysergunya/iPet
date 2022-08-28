import UIKit

class StateView: UIView {
    
    let stateCount: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = .init(hex: 0x00000)
        label.text = "11111111"
        
        return label
    }()
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = .init(hex: 0x2B2A29)
        label.numberOfLines = 2
        label.text = "11111111"
        
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
