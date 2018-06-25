import Alamofire
import Kingfisher
import UIKit
import youtube_ios_player_helper

final class FlightDetailsViewController: UIViewController, StoryboardInstantiable {
  
    static var storyboardName: String = "FlightDetailsViewController"
    
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var launchDetailsLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var payloadMassLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    
    private var flight: Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = flight?.missionName
        setMainInfo()
        loadFlightImage()
    }
    
    func setupFlight(_ flight: Flight?) {
        self.flight = flight
    }
    
    private func setMainInfo() {
        launchDateLabel?.text = formatedFlightDate(flightDate: flight?.launchDateUnix ?? 0).uppercased()
        launchDetailsLabel?.text = flight?.details
        rocketNameLabel?.text = "Rocket name: \(flight?.rocket.rocketName ?? "")"
        payloadMassLabel?.text = "Payload mass: \(flight?.rocket.secondStage.payloads.first?.payloadMassKg ?? 0) Kg"
    }
    
    private func loadVideo() {
        
        guard let ytVideoID = flight?.links.videoLink.getYTVideoID() else { return }
        ytPlayerView.delegate = self
        ytPlayerView.load(withVideoId: ytVideoID)
    }
    
    func loadFlightImage() {
        let imageURL = flight?.links.videoLink.youtubePreviewImageURL()
        guard let url = imageURL else { return }
        
        flightImage?.kf.setImage(with: URL(string: url),
                                 placeholder: nil,
                                 options: [.transition(ImageTransition.fade(0.5))],
                                 progressBlock: nil,
                                 completionHandler: { [weak self] (image, _, _, _) in
                                    self?.flightImage.image = image
                                    self?.loadingIndicator.stopAnimating()
        })
    }
    
    @IBAction func swhowFlightDetailsOnWikipedia() {
        openURL(stringURL: flight?.links.wikipedia ?? "")
    }
    
    @IBAction func flightImageTap(_ sender: UITapGestureRecognizer) {
        loadVideo()
        self.loadingIndicator.startAnimating()
    }
}

extension FlightDetailsViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.loadingIndicator.stopAnimating()
        flightImage.isHidden = true
        ytPlayerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        self.loadingIndicator.stopAnimating()
    }
}
