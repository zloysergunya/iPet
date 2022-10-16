import UIKit

class UserDataView: RootView {
   
    private let addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.addPhotoButton()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    let photoPlaceholderImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.manPhoto())
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35.0
        imageView.layer.borderColor = R.color.orangeAccentLight()?.cgColor
        imageView.layer.borderWidth = 2.0
        
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Иван Иванов"
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "coala_034"
        label.font = R.font.sfuiTextMedium(size: 12.0)
        label.textColor = R.color.mainGray()
        
        return label
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пуфик"
        label.font = R.font.sfuiTextRegular(size: 13.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    private lazy var userDataStackView = UIStackView(
        views: [
            nameLabel,
            userNameLabel,
            petNameLabel
        ], spacing: 3.0, alignment: .leading)
    
    override func setup() {
        
        backgroundColor = R.color.background()

        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(photoPlaceholderImageView)
        addSubview(addImageView)
        addSubview(nameLabel)
        addSubview(userNameLabel)
        addSubview(petNameLabel)
        
        addImageView.snp.makeConstraints { make in
            make.right.equalTo(photoPlaceholderImageView.snp.right).offset(-8.0)
            make.bottom.equalTo(photoPlaceholderImageView.snp.bottom).offset(4.0)
            make.size.equalTo(16.0)
        }
        
        photoPlaceholderImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(70.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(photoPlaceholderImageView.snp.right).offset(25.0)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4.0)
            make.right.equalToSuperview()
            make.left.equalTo(photoPlaceholderImageView.snp.right).offset(25.0)
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(9.0)
            make.right.equalToSuperview()
            make.left.equalTo(photoPlaceholderImageView.snp.right).offset(25.0)
        }
    }
    
}


