import UIKit

class FlighTableViewCell: UITableViewCell {

    static let identifier = "FlighTableViewCell"
    
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var flightImage: UIImageView!
    
    func setupCell(flight: Flight) {
        missionNameLabel.text = flight.missionName
        launchDateLabel.text = formatFlightDate(flightDate: flight.launchDateUnix).uppercased()
        print(flight.links.videoLink.capturedGroups(withRegex: "[?&;]v=([^?&;]+)"))
    }
}
