import UIKit
import SnapKit

class AppSettingsContentView: RootView {
    
    let closedProfileView = AppSettingsView(title: "Зыкрытый профиль", type: .switcher(isOn: false))
    let notificationsView = AppSettingsView(title: "Уведомления", type: .switcher(isOn: false))
    let languageSetting = AppSettingsView(title: "Язык:", type: .button(title: "Русский"))
    let recallView = AppSettingsView(title: "Оставить отзыв", type: .image(R.image.recall()))
    let socialNetworksView: AppSettingsView = {
        let view = AppSettingsView(title: "Наши соцсети", type: .image(R.image.socialNetworks()))
        view.separator.isHidden = true
    
        return view
    }()
    
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
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        appSettingsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16.0)
        }
    }
    
}
