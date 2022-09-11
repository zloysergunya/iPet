import UIKit

class SocialView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.mainGray()
        
        return label
    }()
    
    let followImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.subscribers()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var stackView = UIStackView(
        views: [titleLabel, followImageView],
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
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        followImageView.snp.makeConstraints { make in
            make.width.equalTo(121.0)
            make.height.equalTo(31.0)
        }
    }
    
}
