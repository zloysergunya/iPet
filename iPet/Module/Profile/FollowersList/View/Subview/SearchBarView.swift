import UIKit

class SearchBarView: UITextField {
    
    let searchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTextField()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        backgroundColor = R.color.background()
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = R.color.darkGray()?.cgColor
        font = R.font.sfuiTextRegular(size: 13.0)
        placeholder = "Искать друзей"
        textColor = R.color.textTF()
        tintColor = R.color.textTF()
    }
    
    private func setupConstraints() {
        addSubview(searchImage)
        
        searchImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(14.0)
            make.size.equalTo(26.0)
        }
    }
    
}
