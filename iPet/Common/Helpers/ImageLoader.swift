import Kingfisher
import UIKit

class ImageLoader {
    
    @discardableResult
    static func setImage(url: String?,
                         imageView: UIImageView,
                         placeholderImage: UIImage? = nil,
                         completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        guard let url = url else {
            return nil
        }
        
        let options: KingfisherOptionsInfo = [
            .loadDiskFileSynchronously,
            .transition(.fade(0.2))
        ]

        return imageView.kf.setImage(with: URL(string: url), placeholder: placeholderImage, options: options, completionHandler: completionHandler)
    }
    
}
