import UIKit
import SnapKit

class ModalPhysicalStateView: RootView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    let thumbView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2.0
        view.backgroundColor = .init(hex: 0xC4C4C4)
        
        return view
    }()
    
    let viewForClose: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
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
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.blueAccent()
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 17.0)
        button.setTitleColor(R.color.background(), for: .normal)
        button.layer.cornerRadius = 10.0
        
        return button
    }()
    
    let blurView: VisualEffectView = {
        let blurView = VisualEffectView()
        blurView.colorTint = .init(hex: 0xF4F4F4).withAlphaComponent(0.5)
        blurView.blurRadius = 6.0
        
        return blurView
    }()

    override func setup() {
        super.setup()
        
        containerView.backgroundColor = R.color.background()
        
        addSubview(blurView)
        addSubview(containerView)
        addSubview(viewForClose)
        
        containerView.addSubview(thumbView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(actionButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        viewForClose.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.top)
            make.top.left.right.equalToSuperview()
        }
        
        thumbView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(36.0)
            make.height.equalTo(4.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbView.snp.bottom).offset(17.0)
            make.right.left.equalToSuperview().inset(24.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(24.0)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30.0)
            make.left.right.equalToSuperview().inset(64.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30.0)
            make.height.equalTo(56.0)
        }
    }
    
}
