import UIKit
import Alamofire
import AlamofireImage
import youtube_ios_player_helper

final class FlightDetailsViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String = "FlightDetailsViewController"
    
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var launchDetailsLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var payloadMassLabel: UILabel!
    @IBOutlet weak var videoLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    
    private var flight: Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = flight?.missionName
        setMainInfo()
        loadFlightImage()
        loadVideo()
    }
    
    func setupFlight(_ flight: Flight?) {
        self.flight = flight
    }
    
    private func setMainInfo() {
        launchDateLabel?.text = formatFlightDate(flightDate: flight?.launchDateUnix ?? 0).uppercased()
        launchDetailsLabel?.text = flight?.details
        rocketNameLabel?.text = "Rocket name: \(flight?.rocket.rocketName ?? "")"
        payloadMassLabel?.text = "Payload mass: \(flight?.rocket.secondStage.payloads.first?.payloadMassKg ?? 0) Kg"
    }
    
    private func loadVideo() {
        
        guard let ytVideoID = flight?.links.videoLink.getYTVideoID() else { return }
        ytPlayerView.load(withVideoId: ytVideoID)
    }
    
    func loadFlightImage() {
        let imageURL = flight?.links.videoLink.youtubePreviewImageURL()
        guard let url = imageURL else { return }

        Alamofire.request(url).responseImage { [weak self] response in
            
            if let image = response.result.value {
                self?.videoLoadingIndicator.stopAnimating()
                self?.flightImage.image = image
                UIView.animate(withDuration: 0.2, animations: {
                    self?.flightImage.alpha = 1
                })
            }
        }
    }
    
    @IBAction func swhowFlightDetailsOnWikipedia() {
        openURL(stringURL: flight?.links.wikipedia ?? "")
    }
    
    @IBAction func flightImageTap(_ sender: UITapGestureRecognizer) {
        flightImage.isHidden = true
        ytPlayerView.playVideo()
    }
}