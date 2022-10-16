import UIKit

class SocialView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.mainGray()
        
        return label
    }()
    
    lazy var userStackView = UIStackView(
        views: [],
        axis: .horizontal,
        spacing: -12.0
    )
    
    lazy var rootView = UIStackView(
        views: [titleLabel, userStackView],
        axis: .vertical,
        spacing: 8.0
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = R.color.background()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(rootView)
        
        rootView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
