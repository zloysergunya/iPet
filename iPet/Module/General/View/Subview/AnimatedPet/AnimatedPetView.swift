import UIKit
import SnapKit
import Lottie

class AnimatedPetView: UIView {
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.animationSpeed = 1.0
        view.loopMode = .loop
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(animationView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func setAnimation(_ url: URL, loopMode: LottieLoopMode = .loop, completion: LottieCompletionBlock? = nil) {
        Animation.loadedFrom(url: url, closure: { [weak self] animation in
            guard let self = self else {
                return
            }
            
            self.animationView.animation = animation
            self.animationView.loopMode = loopMode
            self.animationView.play(completion: completion)
            
        }, animationCache: LRUAnimationCache.sharedCache)
    }

}
