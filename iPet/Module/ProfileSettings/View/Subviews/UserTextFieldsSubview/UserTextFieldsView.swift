import UIKit
import SnapKit

class UserTextFieldsView: RootView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя:"
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username:"
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Кличка питомца:"
        label.font = R.font.sfuiTextRegular(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let nameTextField = OneLineTextField(placeholder: "Иван")
    let userNameTextField = OneLineTextField(placeholder: "coala_034")
    let petNameTextField = OneLineTextField(placeholder: "Пуфик")
    
    private(set) lazy var nameStack = UIStackView(views: [
        nameLabel,
        nameTextField
    ], spacing: 14.0)
    
    private(set) lazy var userNameStack = UIStackView(views: [
        userNameLabel,
        userNameTextField
    ], spacing: 14.0)
    
    private(set) lazy var petNameStack = UIStackView(views: [
        petNameLabel,
        petNameTextField
    ], spacing: 14.0)
    
    override func setup() {
        super.setup()

        backgroundColor = R.color.background()
        
        addSubview(nameStack)
        addSubview(userNameStack)
        addSubview(petNameStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        nameStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(30.0)
        }
        
        userNameStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(30.0)
        }
        
        petNameStack.snp.makeConstraints { make in
            make.top.equalTo(userNameStack.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(30.0)
            make.bottom.equalToSuperview()
        }
    }
}
