import UIKit

class IntiveFriendsView: RootView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.background()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = R.color.disabled()?.cgColor
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    private let inviteFriendsLabel: UILabel = {
        let label = UILabel()
        label.text = "Пригласить друзей"
        label.font = R.font.sfuiTextSemibold(size: 14.0)
        label.textColor = R.color.grayText()
        
        return label
    }()
    
    private let addStepsLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 20 степсов"
        label.font = R.font.sfuiTextRegular(size: 14.0)
        label.textColor = R.color.grayText()
        
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.rightArrow()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func setup() {
         
        backgroundColor = R.color.background()
        
        addSubview(containerView)
        containerView.addSubview(inviteFriendsLabel)
        containerView.addSubview(addStepsLabel)
        containerView.addSubview(arrowImageView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(77.0)
        }
        
        inviteFriendsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.0)
            make.left.equalToSuperview().offset(23.0)
        }
        
        addStepsLabel.snp.makeConstraints { make in
            make.top.equalTo(inviteFriendsLabel.snp.bottom).offset(7.0)
            make.left.equalToSuperview().offset(23.0)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17.0)
            make.centerY.equalToSuperview()
            make.height.equalTo(20.0)
            make.width.equalTo(10.0)
        }
    }
    
}
