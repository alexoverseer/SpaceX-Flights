import UIKit
import Alamofire
import AlamofireImage

class FlighTableViewCell: UITableViewCell {

    static let identifier = "FlighTableViewCell"
    
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var flightImage: UIImageView!
    
    func setupCell(flight: Flight) {
        missionNameLabel.text = flight.missionName
        launchDateLabel.text = formatFlightDate(flightDate: flight.launchDateUnix).uppercased()
        loadThumbnailImage(imageURL: flight.links.videoLink.youtubePreviewImageURL())
    }
    
    private func loadThumbnailImage(imageURL: String) {
        
        Alamofire.request(imageURL).responseImage { [weak self] response in
            
            if let image = response.result.value {
                self?.flightImage.image = image
                UIView.animate(withDuration: 0.2, animations: {
                    self?.flightImage.alpha = 1
                })
            }
        }
    }
}
