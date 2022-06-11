import UIKit

class RadialGradientView: UIView {

    private let gradientLayer = RadialGradientLayer()

    var colors: [UIColor] {
        get { return gradientLayer.colors }
        set { gradientLayer.colors = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }

}

fileprivate class RadialGradientLayer: CALayer {

    var center: CGPoint {
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }

    var radius: CGFloat {
        return (bounds.width + bounds.height) / 2
    }

    var colors: [UIColor] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    var cgColors: [CGColor] {
        return colors.map({ $0.cgColor })
    }

    override init() {
        super.init()
        
        needsDisplayOnBoundsChange = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
    }

    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 0.4]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            return
        }
        
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }

}
