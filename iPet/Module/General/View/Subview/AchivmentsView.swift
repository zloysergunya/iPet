import UIKit
import SnapKit

class AchivmentsView: UIView {
    
    var baseShapeLayer: CAShapeLayer?
    var filledShapeLayer: CAShapeLayer?
    
    let images: [UIImageView] = {
        var array: [UIImageView] = []
        for i in 0..<5 {
            let side = 34.0
            let imageView = UIImageView()
            imageView.tag = i
            imageView.layer.cornerRadius = side / 2
            imageView.frame.size = CGSize(width: side, height: side)
            imageView.isUserInteractionEnabled = true
            array.append(imageView)
        }
        
        return array
    }()
    
    private let color: UIColor = .init(hex: 0xDADADA)
    private let lineSize: CGFloat = 7.0
    
    private var completedColor: UIColor = .init(hex: 0xAFF68D)
    private var maxValue: CGFloat = 1.0
    private var arcCenter: CGPoint {
        return CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    private var radius: CGFloat {
        return frame.width / 2
    }
    
    private func drawBaseLayer() {
        let half = min(arcCenter.x, arcCenter.y)
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi
            
        let circlePath = UIBezierPath(
            arcCenter: arcCenter,
            radius: half - lineSize / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        baseShapeLayer?.removeFromSuperlayer()
        baseShapeLayer = CAShapeLayer()
        baseShapeLayer?.path = circlePath.cgPath
        baseShapeLayer?.lineWidth = lineSize
        baseShapeLayer?.fillColor = UIColor.clear.cgColor
        baseShapeLayer?.strokeColor = color.cgColor
        layer.insertSublayer(baseShapeLayer!, at: 0)
    }
    
    private func setupCompletedAchivments(completed: Int) {
        images.forEach({ $0.removeFromSuperview() })
        
        for i in 0..<images.count {
            let angle: CGFloat
            switch i {
            case 0: angle = .pi
            case 1: angle = (3 * .pi) / 4
            case 2: angle = .pi / 2
            case 3: angle = .pi / 4
            default: angle = 0
            }

            let x = arcCenter.x + radius * cos(-angle)
            let y = arcCenter.y + radius * sin(-angle)
            
            images[i].image = i < completed ? R.image.completedAchivment() : R.image.missedAchivment()
            images[i].backgroundColor = i < completed ? completedColor : color
            addSubview(images[i])
            images[i].center = CGPoint(x: abs(x), y: abs(y))
        }
    }
    
    func drawFilledLayer(completed: Int, completedColor: UIColor?) {
        setColor(completedColor: completedColor)
        drawBaseLayer()
        setupCompletedAchivments(completed: completed)
        
        let currentValue: CGFloat
        switch completed {
        case 1: currentValue = 0.25
        case 2: currentValue = 0.37
        case 3: currentValue = 0.5
        case 4: currentValue = 0.63
        case 5: currentValue = 1
        default: currentValue = 0
        }
        
        let half = min(arcCenter.x, arcCenter.y)
        let startAngle: CGFloat = .pi / 2
        let endValue: CGFloat = currentValue / maxValue
        let endAngle: CGFloat = (endValue * 2 * .pi) + startAngle
            
        let circlePath = UIBezierPath(
            arcCenter: arcCenter,
            radius: half - lineSize / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        filledShapeLayer?.removeFromSuperlayer()
        filledShapeLayer = CAShapeLayer()
        filledShapeLayer?.path = circlePath.cgPath
        filledShapeLayer?.lineWidth = lineSize
        filledShapeLayer?.fillColor = UIColor.clear.cgColor
        filledShapeLayer?.strokeColor = self.completedColor.cgColor
        layer.insertSublayer(filledShapeLayer!, above: baseShapeLayer)
    }
    
    func setColor(completedColor: UIColor?) {
        if let completedColor = completedColor {
            self.completedColor = completedColor
        }
        
        filledShapeLayer?.strokeColor = self.completedColor.cgColor
    }
    
}
