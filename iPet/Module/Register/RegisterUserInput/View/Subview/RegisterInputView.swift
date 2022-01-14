import UIKit
import SnapKit

class RegisterInputView: UIView {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = R.color.blueAccent()
        textField.font = R.font.montserratRegular(size: 16.0)
        textField.tintColor = R.color.blueAccent()
        
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0xFF0000)
        label.font = R.font.montserratRegular(size: 12.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(errorLabel)
        addSubview(textField)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.underlined(color: R.color.blueAccent() ?? .blue)
    }
    
    private func setupConstraints() {
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(56.0)
        }
            
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
            make.bottom.equalToSuperview().offset(-10.0)
        }
        
    }
    
}
