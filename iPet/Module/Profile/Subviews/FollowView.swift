import UIKit

class FollowView: UIView {

    let followers = SocialView()
    let following = SocialView()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.disabled()
        
        return view
    }()
    
    private let verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.disabled()
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(followers)
        addSubview(following)
        addSubview(horizontalView)
        addSubview(verticalView)
        
        followers.rootView.alignment = .leading
        following.rootView.alignment = .trailing
        
        horizontalView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        verticalView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.height.equalTo(89.0)
            make.width.equalTo(1.0)
        }
        
        followers.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(5.0)
            make.right.equalTo(verticalView.snp.left)
            make.bottom.equalTo(horizontalView.snp.top).offset(-12.0)
        }
        
        following.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-5.0)
            make.left.equalTo(verticalView.snp.right)
            make.bottom.equalTo(horizontalView.snp.bottom).offset(-12.0)
        }
    }
}
