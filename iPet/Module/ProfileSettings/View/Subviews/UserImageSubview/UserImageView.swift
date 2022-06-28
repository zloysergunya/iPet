import UIKit
import SnapKit

class UserImageView: UIView {
    
    let circleImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.manPhoto())
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = R.color.orangeAccent()?.cgColor
        imageView.layer.borderWidth = 3.0
        
        return imageView
    }()
    
    private let addPhotoButton: UIImageView = {
        let view = UIImageView()
        view.image = R.image.addPhotoButton()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleImageView)
        addSubview(addPhotoButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        circleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(circleImageView.snp.bottom).offset(-20.0)
            make.left.equalTo(circleImageView.snp.right).offset(-37.0)
            make.width.height.equalTo(24.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2.0
    }
}
