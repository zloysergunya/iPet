import UIKit
import SnapKit

class AnimalPhotoView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.borderColor = R.color.background()?.cgColor
        layer.borderWidth = 2.0
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2.0
    }
    
}
