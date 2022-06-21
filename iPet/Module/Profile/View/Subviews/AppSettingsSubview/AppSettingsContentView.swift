import UIKit
import SnapKit

class AppSettingsContentView: RootView {
    
    let closedProfileView = AppSettingsView(title: "Зыкрытый профиль", type: .switcher(isOn: false))
    let notificationsView = AppSettingsView(title: "Уведомления", type: .switcher(isOn: false))
    let languageSetting = AppSettingsView(title: "Язык:", type: .button(title: "Русский"))
    let recallView = AppSettingsView(title: "Оставить отзыв", type: .image(R.image.recall()))
    let socialNetworksView = AppSettingsView(title: "Наши соцсети", type: .image(R.image.socialNetworks()))
    
    private(set) lazy var appSettingsStackView = UIStackView(views: [
        closedProfileView,
        notificationsView,
        languageSetting,
        recallView,
        socialNetworksView
    ])
    
    override func setup() {
        super.setup()
        
        appSettingsStackView.layer.cornerRadius = 10.0
        appSettingsStackView.clipsToBounds = true
        
        addSubview(appSettingsStackView)
        
        appSettingsStackView.arrangedSubviews.enumerated().forEach { element in
            if let view = element.element as? AppSettingsView {
                view.separator.isHidden = element.offset == appSettingsStackView.arrangedSubviews.count - 1
            }
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        appSettingsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16.0)
        }
    }
    
}
