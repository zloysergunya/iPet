import UIKit
import SnapKit

class ActivityProgressView: UIView {
    
    private let color: UIColor
    private let lineSize: CGFloat = 5.0
    
    private var currentValue: CGFloat = 0.0
    private var maxValue: CGFloat = 100.0
    private var arcCenter: CGPoint {
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    private var radius: CGFloat {
        return (bounds.width + bounds.height) / 2
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextBold(size: 18.0)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 10.0)
        label.textColor = .init(hex: 0x6E6C6B)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    func draw(with title: String, subtitle: String, currentValue: CGFloat, maxValue: CGFloat = 100.0) {
        self.currentValue = max(maxValue / self.maxValue, currentValue)
        self.maxValue = maxValue
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        drawLayer()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(14.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6.0)
            make.left.right.equalToSuperview()
        }
    }
    
    private func drawLayer() {
        let half = min(arcCenter.x, arcCenter.y)
        let startAngle: CGFloat = 0
        let endValue: CGFloat = currentValue / maxValue
        let endAngle: CGFloat = (endValue * 2 * .pi) + startAngle
            
        let circlePath = UIBezierPath(
            arcCenter: arcCenter,
            radius: half - lineSize / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineWidth = lineSize
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = color.cgColor
        
        layer.insertSublayer(shapeLayer, at: 0)
    }

}
