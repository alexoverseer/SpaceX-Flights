import Alamofire
import Kingfisher
import Reusable
import UIKit

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
        
        flightImage?.kf.setImage(with: URL(string: imageURL),
                                 placeholder: nil,
                                 options: [.transition(ImageTransition.fade(0.5))],
                                 progressBlock: nil,
                                 completionHandler: { [weak self] (image, _, _, _) in
                                    self?.flightImage.image = image
        })
    }
}
