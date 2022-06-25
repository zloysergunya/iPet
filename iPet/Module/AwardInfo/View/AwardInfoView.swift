import UIKit
import SnapKit

class AwardInfoView: RootView {
    
    private let blurView: VisualEffectView = {
        let view = VisualEffectView()
        view.colorTint = .white.withAlphaComponent(0.5)
        view.blurRadius = 6.0
        
        return view
    }()
    
    let viewForClose: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = R.font.sfuiTextBold(size: 18.0)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.color.darkGray()
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var containerStack = UIStackView(views: [
        imageView,
        titleLabel,
        subtitleLabel,
        progressLabel
    ], spacing: 12.0, distribution: .fill)
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОК", for: .normal)
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 17.0)
        button.setTitleColor(R.color.background(), for: .normal)
        button.layer.cornerRadius = 10.0
        button.backgroundColor = R.color.blueAccent()
        
        return button
    }()
    
    private lazy var rootStack = UIStackView(views: [
        containerStack,
        actionButton
    ], spacing: 22.0, distribution: .fill)

    override func setup() {
        super.setup()
        
        backgroundColor = .clear
        
        addSubview(blurView)
        addSubview(viewForClose)
        addSubview(rootStack)
        
        containerStack.layoutMargins = UIEdgeInsets(top: -1.0, left: 28.0, bottom: 28.0, right: 28.0)
        containerStack.isLayoutMarginsRelativeArrangement = true
        containerStack.backgroundColor = .white
        containerStack.layer.cornerRadius = 10.0
        containerStack.layer.masksToBounds = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewForClose.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rootStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(64.0)
        }
        
        actionButton.snp.makeConstraints { make in
            make.height.equalTo(56.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(118.0)
        }
    }
    
}
