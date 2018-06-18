import UIKit

final class FlightsViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String = "FlightsViewController"
    
    private var spaceFlights: [Flight]?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var flightsTableView: UITableView! {
        didSet {
            flightsTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemImage()
        registerCell()
        getSpaceFlights()
    }
    
    private func setNavigationItemImage() {
        
        let spaceXImage = UIImageView(image: #imageLiteral(resourceName: "SpaceX_logo"))
        spaceXImage.contentMode = .scaleAspectFit
        navigationItem.titleView = spaceXImage
    }
    
    private func registerCell() {
        flightsTableView.register(UINib(nibName: FlighTableViewCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: FlighTableViewCell.identifier)
    }
    
    private func getSpaceFlights() {
        
        SpaceFlights().requestFlights(onSuccess: { [weak self] flights in
            self?.spaceFlights = flights
            self?.spaceFlights?.reverse()
            self?.loadingIndicator.stopAnimating()
            self?.flightsTableView.reloadData()
        }) { [weak self] error in
            self?.loadingIndicator.stopAnimating()
            
            let okAction = AlertAction(onSelect: {}, name: "OK", style: .default)
            let alert = UIAlertController(info: AlertInfo(title: "Error", message: error.message, actions: [okAction]))
            self?.present(alert, animated: true)
        }
    }
}

extension FlightsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.spaceFlights?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flightCell = tableView.dequeueReusableCell(withIdentifier: FlighTableViewCell.identifier, for: indexPath) as! FlighTableViewCell
        if let spaceFlights = spaceFlights {
            flightCell.setupCell(flight: spaceFlights[indexPath.row])
        }
        
        return flightCell
    }
}

extension FlightsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let flightDetailsController = FlightDetailsViewController.instantiate()
        flightDetailsController.setupFlight(self.spaceFlights?[indexPath.row])
        navigationController?.pushViewController(flightDetailsController, animated: true)
    }
}
