import Kingfisher
import UIKit

class ImageLoader {
    
    @discardableResult
    static func setImage(url: String?,
                         imageView: UIImageView,
                         placeholderImage: UIImage? = nil,
                         side: CGFloat? = nil,
                         completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        guard let url = url else { return nil }
        
        var options: KingfisherOptionsInfo = [
            .loadDiskFileSynchronously,
            .transition(.fade(0.2)),
        ]
        
        if let side = side {
            let width = side * UIScreen.main.scale
            let processor = RoundCornerImageProcessor(cornerRadius: width / 2,
                                                      targetSize: .init(width: width, height: width))
            options.append(.processor(processor))
        }

        return imageView.kf.setImage(with: URL(string: url), placeholder: placeholderImage, options: options, completionHandler: completionHandler)
    }
    
}
