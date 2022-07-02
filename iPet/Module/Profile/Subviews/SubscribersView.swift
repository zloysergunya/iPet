import UIKit

class SubscribersView: RootView {

    let subscribersLabel: UILabel = {
        let label = UILabel()
        label.text = "Подписчики (85)"
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.grayText()
        
        return label
    }()
    
    let subscriptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Подписки (15)"
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.grayText()

        return label
    }()
    
    let subscribersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.subscribers()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let subscriptionsImageView: UIImageView = {
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
        
        addSubview(subscribersLabel)
        addSubview(subscriptionsLabel)
        addSubview(subscribersImageView)
        addSubview(subscriptionsImageView)
        addSubview(verticalView)
        addSubview(horizontalView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        subscribersLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        subscriptionsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        subscribersImageView.snp.makeConstraints { make in
            make.top.equalTo(subscribersLabel.snp.bottom).offset(16.0)
            make.left.equalToSuperview()
            make.width.equalTo(118.0)
            make.height.equalTo(31.0)
        }
        
        subscriptionsImageView.snp.makeConstraints { make in
            make.top.equalTo(subscriptionsLabel.snp.bottom).offset(16.0)
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
            make.top.equalTo(subscribersImageView.snp.bottom).offset(12.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
