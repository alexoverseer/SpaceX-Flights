import UIKit
import Alamofire
import SDWebImage
import Reusable

class FlighTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var missionNameLabel: UILabel!
    @IBOutlet private weak var launchDateLabel: UILabel!
    @IBOutlet private weak var flightImage: UIImageView!
    
    func setupCell(viewModel: FlighTableViewCellViewModel) {
        missionNameLabel?.text = viewModel.missionNameText
        launchDateLabel?.text = viewModel.launchDateText
        loadThumbnailImage(imageURL: viewModel.flightImageUrl)
    }
    
    private func loadThumbnailImage(imageURL: String) {
        
        flightImage?.sd_setImage(with: URL(string: imageURL)) { [weak self] (image, error, cacheType, url) in
            self?.flightImage.image = image
            UIView.animate(withDuration: 0.2, animations: {
                self?.flightImage.alpha = 1
            })
        };
    }
}
