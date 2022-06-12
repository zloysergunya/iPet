import UIKit
import SnapKit

class ProfileView: RootView {
    
    private let scrollView = UIScrollView()
    
    private let headerProfileView = HeaderProfileView()
    private let userSettingsContentView = UserSettingsContentView()
    private let appSettingsContentView = AppSettingsContentView()
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "Приложение"
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.textColor = UIColor(hex: 0x5A5856)
        
        return label
    }()
    
    private let socialNetworksImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "socialNetworks")
        
        return imageView
    }()
    
    private lazy var allDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "За время нашего знакомства мы прошли \(distanceNumberLabel.text ?? "много") км!"
        label.font = R.font.sfuiTextRegular(size: 9)
        label.textColor = UIColor(hex: 0x5A5856)
        
        return label
    }()
    
    let distanceNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "230"
        label.font = R.font.sfuiTextRegular(size: 9)
        label.textColor = UIColor(hex: 0x5A5856)
        
        return label
    }()
    
    override func setup() {
        super.setup()
        
        addSubview(scrollView)
        
        scrollView.addSubview(allDistanceLabel)
        scrollView.addSubview(socialNetworksImage)
        scrollView.addSubview(headerProfileView)
        scrollView.addSubview(userSettingsContentView)
        scrollView.addSubview(appLabel)
        scrollView.addSubview(appSettingsContentView)
        
        scrollView.backgroundColor = R.color.background()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerProfileView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30.0)
            make.width.equalToSuperview()
        }
        
        userSettingsContentView.snp.makeConstraints { make in
            make.top.equalTo(headerProfileView.snp.bottom).offset(16.0)
            make.width.equalToSuperview()
        }
        
        appLabel.snp.makeConstraints { make in
            make.top.equalTo(userSettingsContentView.snp.bottom).offset(14.0)
            make.centerX.equalToSuperview()
        }
        
        appSettingsContentView.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(15.0)
            make.width.equalToSuperview()
        }
        
        socialNetworksImage.snp.makeConstraints { make in
            make.top.equalTo(appSettingsContentView.snp.bottom).offset(14.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(186.0)
            make.height.equalTo(35.0)
        }
        
        allDistanceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(socialNetworksImage.snp.bottom).offset(8.0)
        }
    }

}
