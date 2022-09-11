import UIKit

class DataView: UIView {

    let stepCount = StateView()
    let distanceCount = StateView()
    let averageDistanceCount = StateView()
    let caloriesCount = StateView()
    
    let petImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.lemur()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stepCount)
        addSubview(distanceCount)
        addSubview(petImage)
        addSubview(averageDistanceCount)
        addSubview(caloriesCount)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        averageDistanceCount.stateStackView.alignment = .trailing
        caloriesCount.stateStackView.alignment = .trailing
        
        stepCount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36.0)
            make.left.equalToSuperview()
            make.width.equalTo(100.0)
        }
        
        distanceCount.snp.makeConstraints { make in
            make.top.equalTo(stepCount.snp.bottom).offset(13.0)
            make.left.equalToSuperview()
            make.width.equalTo(100.0)
        }
        
        petImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(117.0)
            make.height.equalTo(140.0)
        }
        
        averageDistanceCount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36.0)
            make.right.equalToSuperview()
            make.width.equalTo(100.0)
        }
        
        caloriesCount.snp.makeConstraints { make in
            make.top.equalTo(averageDistanceCount.snp.bottom).offset(13.0)
            make.right.equalToSuperview()
            make.width.equalTo(100.0)
        }
    }
    
}
