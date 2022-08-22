import UIKit

class UserCell: UICollectionViewCell {
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = R.color.background()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = R.color.orangeAccent()?.cgColor

        return imageView
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 18.0)
        label.textColor = R.color.textTF()
        
        return label
    }()
    
    let userPetName: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextSemibold(size: 14.0)
        label.textColor = R.color.grayText()
        
        return label
    }()
    
    let userStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = R.color.background()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImage.layer.cornerRadius = 50.0 / 2.0
    }
    
    private func setupConstraints() {
        contentView.addSubview(userImage)
        contentView.addSubview(userStatus)
        contentView.addSubview(username)
        contentView.addSubview(userPetName)
        
        userImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16.0)
            make.size.equalTo(50.0)
        }
        
        username.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-9.0)
            make.left.equalTo(userImage.snp.right).offset(10.0)
            make.right.equalTo(userStatus.snp.left).offset(10.0)
        }
        
        userPetName.snp.makeConstraints { make in
            make.top.equalTo(username.snp.bottom)
            make.left.equalTo(userImage.snp.right).offset(10.0)
            make.right.equalTo(userStatus.snp.right).inset(10.0)
        }
        
        userStatus.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16.0)
            make.width.equalTo(22.0)
            make.height.equalTo(18.0)
        }
    }
    
}
