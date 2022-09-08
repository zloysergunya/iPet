import UIKit

class PhysicalMetricView: RootView {
   
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.background()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = R.color.orangeAccentLight()?.cgColor
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    let petImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.image.foxMascote()
        
        return imageView
    }()
    
    let physicalStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Поднабрал"
        label.font = R.font.sfuiTextBold(size: 13.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = R.color.orangeAccent()
        progressView.layer.cornerRadius = 10.0
        
        return  progressView
    }()
    
    let countStepsLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 11.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    let countDaysLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfuiTextRegular(size: 11.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    override func setup() {
        backgroundColor = R.color.background()
        
        addSubview(containerView)
        containerView.addSubview(petImage)
        containerView.addSubview(physicalStatusLabel)
        containerView.addSubview(progressView)
        containerView.addSubview(countStepsLabel)
        containerView.addSubview(countDaysLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(93.0)
        }
        
        petImage.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(17.0)
            make.size.equalTo(56.0)
        }
        
        physicalStatusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.0)
            make.left.equalTo(petImage.snp.right).offset(27.0)
            make.right.equalToSuperview().offset(-13.0)
        }
        
        progressView.snp.makeConstraints { make in
            make.left.equalTo(petImage.snp.right).offset(27.0)
            make.right.equalToSuperview().offset(-13.0)
            make.bottom.equalTo(countStepsLabel.snp.top).offset(-10.0)
            make.height.equalTo(5.0)
        }
        
        countStepsLabel.snp.makeConstraints { make in
            make.left.equalTo(petImage.snp.right).offset(27.0)
            make.bottom.equalToSuperview().offset(-18.0)
        }
        
        countDaysLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-13.0)
            make.bottom.equalToSuperview().offset(-18.0)
        }
    }
    
}


