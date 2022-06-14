import UIKit
import SnapKit

class UserSettingsContentView: RootView {

    private let dailyGoalMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Ежедневная цель:"
        view.metricLabel.text = "\(UserSettings.user?.stepsCount ?? 0)"
        view.unitLabel.text = "шагов"
        
        return view
    }()
    
    private let ageMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Возраст:"
        view.metricLabel.text = "\(UserSettings.user?.age ?? 0)"
        view.unitLabel.text = "лет"
        
        return view
    }()
    
    private let heightMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Рост:"
        view.metricLabel.text = "\(UserSettings.user?.height ?? 0)"
        view.unitLabel.text = "см"
        
        return view
    }()
    
    private let weightMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Вес:"
        view.metricLabel.text = "\(UserSettings.user?.weight ?? 0)"
        view.unitLabel.text = "кг"
        
        return view
    }()
    
    private let sexMetricView: UserMetricView = {
        let view = UserMetricView()
        view.titleLabel.text = "Пол:"
        view.metricLabel.text = UserSettings.user?.gender
        view.unitLabel.text = ""
        
        return view
    }()
    
    private(set) lazy var metricStackView = UIStackView(views: [
        dailyGoalMetricView,
        ageMetricView,
        heightMetricView,
        weightMetricView,
        sexMetricView
    ], spacing: 14.0)
    
    override func setup() {
        super.setup()
        
        backgroundColor = R.color.background()
        
        addSubview(metricStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        metricStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(24.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
