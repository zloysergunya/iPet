import UIKit
import SnapKit

class FriendSegmentedControllView: UIView {

    lazy var segmentedControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["День", "Недели", "Месяца"])
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.backgroundColor = R.color.segmentedControl()
        segmentedControll.setTitleTextAttributes([
            // TODO: - переделать цвет
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: R.font.sfuiDisplayRegular(size: 15.0) ?? 15.0], for: .normal)
        segmentedControll.setTitleTextAttributes([
            
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: R.font.sfuiDisplayRegular(size: 15.0) ?? 15.0], for: .selected)
        
        return segmentedControll
    }()

    init() {
        super.init(frame: .zero)
        
        backgroundColor = R.color.secondBackground()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(segmentedControll)
        
        segmentedControll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
