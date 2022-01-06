import UIKit

extension UIView {
    
    func underlined(color: UIColor = UIColor.lightGray) {
        let border = CALayer()
        border.name = "underlined"
        border.borderColor = color.cgColor
        
        let lineWidth: CGFloat = 1
        border.borderWidth = lineWidth
        border.frame = CGRect(x: 0,
                              y: frame.size.height - lineWidth,
                              width: frame.size.width,
                              height: frame.size.height)
        
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
}
