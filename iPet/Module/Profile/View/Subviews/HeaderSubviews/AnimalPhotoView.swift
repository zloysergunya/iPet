import UIKit
import SnapKit

class AnimalPhotoView: UIView {
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.foxMascote())
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderColor = R.color.background()?.cgColor
        imageView.layer.borderWidth = 3.0
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        circleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2.0
    }
    
}
