import UIKit
import SnapKit

class UserSettingsContentView: RootView {

    let dailyGoalMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Ежедневная цель:"
        view.metricLabel.text = "\(UserSettings.user?.stepsCount ?? 0)"
        view.unitLabel.text = "шагов"
        
        return view
    }()
    
    let ageMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Возраст:"
        view.metricLabel.text = "\(UserSettings.user?.age ?? 0)"
        view.unitLabel.text = "лет"
        
        return view
    }()
    
    let heightMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Рост:"
        view.metricLabel.text = "\(UserSettings.user?.height ?? 0)"
        view.unitLabel.text = "см"
        
        return view
    }()
    
    let weightMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Вес:"
        view.metricLabel.text = "\(UserSettings.user?.weight ?? 0)"
        view.unitLabel.text = "кг"
        
        return view
    }()
    
    let sexView: GenderView = {
        let view = GenderView()
        view.genderLabel.text = "Пол:"
        view.genderImage.image = R.image.manGender()
        
        return view
    }()

    private(set) lazy var metricStackView = UIStackView(views: [
        dailyGoalMetricView,
        ageMetricView,
        heightMetricView,
        weightMetricView,
        sexView
    ])
    
    override func setup() {
        super.setup()
        
        addSubview(metricStackView)
        
        metricStackView.layer.cornerRadius = 10.0
        metricStackView.clipsToBounds = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        metricStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
