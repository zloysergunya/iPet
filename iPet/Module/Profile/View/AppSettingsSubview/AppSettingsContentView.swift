import UIKit
import SnapKit

class AppSettingsContentView: RootView {
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Язык:"
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    private let languageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Русский", for: .normal)
        button.setTitleColor(R.color.textPrimary(), for: .normal)
        button.titleLabel?.font = R.font.sfuiTextMedium(size: 18.0)
        
        return button
    }()
    
    private let closedProfileView: AppSettingsView = {
        let view = AppSettingsView()
        view.titleLabel.text = "Зыкрытый профиль"
        
        return view
    }()
    
    private let distanceView: AppSettingsView = {
        let view = AppSettingsView()
        view.titleLabel.text = "Отображать километры"
        
        return view
    }()
    
    private let notificationsView: AppSettingsView = {
        let view = AppSettingsView()
        view.titleLabel.text = "Уведомления"

        return view
    }()
    
    private let faqLabel: UILabel = {
        let label = UILabel()
        label.text = "FAQ"
        label.font = R.font.sfuiTextMedium(size: 18.0)
        label.textColor = R.color.textPrimary()
        
        return label
    }()
    
    private(set) lazy var languageSettingStackView = UIStackView(views: [
        languageLabel,
        languageButton
    ], axis: .horizontal, distribution: .equalSpacing)
    
    private(set) lazy var appSettingsStackView = UIStackView(views: [
        languageSettingStackView,
        closedProfileView,
        distanceView,
        notificationsView,
        faqLabel
    ], spacing: 19.0)
    
    override func setup() {
        super.setup()

        addSubview(appSettingsStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        appSettingsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(24.0)
        }
    }
    
}
