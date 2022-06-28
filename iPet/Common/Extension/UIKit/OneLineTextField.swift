import UIKit
import SnapKit

class OneLineTextField: UITextField {
    
    convenience init(text: String? = nil, font: UIFont = R.font.sfuiDisplayLight(size: 16.0) ?? .systemFont(ofSize: 16.0), placeholder: String?) {
        self.init()
    
        self.text = text
        self.font = font
        self.placeholder = placeholder
        self.borderStyle = .none
        self.addSubview(bottomView)
        
        setupConstraints()
    }
    
    private var bottomView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = R.color.blueAccent()
        
       return view
    }()
    
    private func setupConstraints() {
        bottomView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
}
