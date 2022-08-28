import UIKit
import SnapKit

class UserContentView: RootView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.background()
        
        return view
    }()
    
    let userImageView = UserImageView()
    let userTextFieldsView = UserTextFieldsView()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(R.color.background(), for: .normal)
        button.titleLabel?.font = R.font.sfuiTextSemibold(size: 17.0)
        button.setBackgroundColor(R.color.blueAccent(), for: .normal)
        button.setBackgroundColor(R.color.blueAccentDarker(), for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        
        return button
    }()
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.background()
        
        addSubview(containerView)
        containerView.addSubview(userImageView)
        containerView.addSubview(userTextFieldsView)
        containerView.addSubview(saveButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20.0)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(117.0)
        }
        
        userTextFieldsView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20.0)
            make.width.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(userTextFieldsView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(16.0)
            make.height.equalTo(56.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
