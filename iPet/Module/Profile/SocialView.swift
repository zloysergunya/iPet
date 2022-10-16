import UIKit

class SocialView: RootView {

    let followersLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.grayText()
        
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.grayText()

        return label
    }()
    
    let followersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.subscribers()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let followingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.subscribers()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
   
    private let verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.disabled()
        
        return view
    }()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.disabled()
        
        return view
    }()
    
    override func setup() {
         
        backgroundColor = R.color.background()
        
        addSubview(followersLabel)
        addSubview(followingLabel)
        addSubview(followersImageView)
        addSubview(followingImageView)
        addSubview(verticalView)
        addSubview(horizontalView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        followersLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        followingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        followersImageView.snp.makeConstraints { make in
            make.top.equalTo(followersLabel.snp.bottom).offset(16.0)
            make.left.equalToSuperview()
            make.width.equalTo(118.0)
            make.height.equalTo(31.0)
        }
        
        followingImageView.snp.makeConstraints { make in
            make.top.equalTo(followingLabel.snp.bottom).offset(16.0)
            make.right.equalToSuperview()
            make.width.equalTo(118.0)
            make.height.equalTo(31.0)
        }
        
        verticalView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(1.0)
        }
        
        horizontalView.snp.makeConstraints { make in
            make.top.equalTo(followersImageView.snp.bottom).offset(12.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
