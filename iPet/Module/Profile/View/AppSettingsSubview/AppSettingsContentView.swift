import UIKit
import SnapKit

class AppSettingsContentView: RootView {
    
    let closedProfileView: AppSettingsView = {
        let view = AppSettingsView()
        view.titleLabel.text = "Зыкрытый профиль"
        
        return view
    }()
    
    let notificationsView: AppSettingsView = {
        let view = AppSettingsView()
        view.titleLabel.text = "Уведомления"

        return view
    }()
    
    let languageSetting: LanguageSetting = {
        let view = LanguageSetting()
        view.languagelabel.text = "Язык:"
        view.languageButton.setTitle("Русский", for: .normal)
        
        return view
    }()
    
    let recallView: RecalView = {
        let view = RecalView()
        view.recallLabel.text = "Оставить отзыв"
        view.recallImage.image = R.image.recall()
        
        return view
    }()
    
    let socialNetworksView: SocialNetworksView = {
        let view = SocialNetworksView()
        view.socialNetworksLabel.text = "Наши соцсети"
        view.socialNetworksImage.image = R.image.socialNetworks()
        
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
