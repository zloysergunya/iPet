import UIKit
import SnapKit

class ProfileView: RootView {
    
    private lazy var scrollView = UIScrollView()
    
    let headerProfileView = HeaderProfileView()
    private let userSettingsContentView = UserSettingsContentView()
    let appSettingsContentView = AppSettingsContentView()
    let exitAccountContainerView = ExitContainerView()
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "Приложение"
        label.font = R.font.sfuiTextBold(size: 17.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()

    private lazy var allDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Всего пройдено:"
        label.font = R.font.sfuiTextMedium(size: 14.0)
        label.textColor = R.color.darkGray()
        
        return label
    }()
    
    private let distanceNumberLabel: UILabel = {
        let label = UILabel()
        label.text =  "\(230) км"
        label.font = R.font.sfuiTextMedium(size: 14.0)
        label.textColor = R.color.orangeAccent()
        
        return label
    }()
    
    private(set) lazy var allDistanceStack = UIStackView(views: [
        allDistanceLabel,
        distanceNumberLabel
    ], axis: .horizontal, spacing: 2.0, alignment: .center)
    
    override func setup() {
        super.setup()
        
        addSubview(scrollView)
        
        scrollView.addSubview(headerProfileView)
        scrollView.addSubview(userSettingsContentView)
        scrollView.addSubview(appLabel)
        scrollView.addSubview(appSettingsContentView)
        scrollView.addSubview(allDistanceStack)
        scrollView.addSubview(exitAccountContainerView)
        
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
            make.top.equalTo(headerProfileView.snp.bottom).offset(20.0)
            make.width.equalToSuperview()
        }
        
        appLabel.snp.makeConstraints { make in
            make.top.equalTo(userSettingsContentView.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
        }
        
        appSettingsContentView.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(20.0)
            make.width.equalToSuperview()
        }
        
        allDistanceStack.snp.makeConstraints { make in
            make.top.equalTo(appSettingsContentView.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview().offset(35.0)
        }
        
        exitAccountContainerView.snp.makeConstraints { make in
            make.top.equalTo(allDistanceStack.snp.bottom).offset(20.0)
            make.width.equalToSuperview()
        }
    }

}
