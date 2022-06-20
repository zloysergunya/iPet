import UIKit
import SnapKit

class OneLineTextField: UITextField {
    
    convenience init(font: UIFont = R.font.sfuiDisplayLight(size: 16.0) ?? .systemFont(ofSize: 16.0), placeholder: String?) {
        self.init()
    
        self.font = font
        self.placeholder = placeholder
        self.borderStyle = .none
        
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = R.color.blueAccent()
        self.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}
