import UIKit
import SnapKit

class ProfileSettingsContentView: RootView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.background()
        
        return view
    }()
    
    let headerProfileSettingsView = HeaderProfileSettingsView()
    let userSettingsContentView = UserSettingsContentView()
    let appSettingsContentView = AppSettingsContentView()
    let exitAccountContainerView = ExitContainerView()
    
    private let userDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Личные данные"
        label.font = R.font.sfuiTextBold(size: 24.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "Приложение"
        label.font = R.font.sfuiTextBold(size: 24.0)
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
    
    let distanceNumberLabel: UILabel = {
        let label = UILabel()
        label.text =  "\(230) км"
        label.font = R.font.sfuiTextMedium(size: 14.0)
        label.textColor = R.color.orangeAccent()
        
        return label
    }()
    
    private(set) lazy var totalDistanceStack = UIStackView(views: [
        allDistanceLabel,
        distanceNumberLabel
    ], axis: .horizontal, spacing: 2.0, alignment: .center)
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.background()
        
        addSubview(containerView)
        
        containerView.addSubview(headerProfileSettingsView)
        containerView.addSubview(userDataLabel)
        containerView.addSubview(userSettingsContentView)
        containerView.addSubview(appLabel)
        containerView.addSubview(appSettingsContentView)
        containerView.addSubview(totalDistanceStack)
        containerView.addSubview(exitAccountContainerView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerProfileSettingsView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(18.0)
            make.width.equalToSuperview()
        }
        
        userDataLabel.snp.makeConstraints { make in
            make.top.equalTo(headerProfileSettingsView.snp.bottom).offset(30.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        userSettingsContentView.snp.makeConstraints { make in
            make.top.equalTo(userDataLabel.snp.bottom).offset(30.0)
            make.width.equalToSuperview()
        }
        
        appLabel.snp.makeConstraints { make in
            make.top.equalTo(userSettingsContentView.snp.bottom).offset(30.0)
            make.left.right.equalToSuperview().inset(16.0)
        }
        
        appSettingsContentView.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(30.0)
            make.width.equalToSuperview()
        }
        
        totalDistanceStack.snp.makeConstraints { make in
            make.top.equalTo(appSettingsContentView.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview().offset(40.0)
        }
        
        exitAccountContainerView.snp.makeConstraints { make in
            make.top.equalTo(totalDistanceStack.snp.bottom).offset(41.0)
            make.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10.0)
        }
    }

}
