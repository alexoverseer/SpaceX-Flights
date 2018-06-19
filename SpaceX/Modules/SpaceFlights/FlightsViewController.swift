import UIKit

final class FlightsViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String = "FlightsViewController"
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var flightsTableView: UITableView!
    
    lazy fileprivate var flightsViewModel: FlightsViewModel = {
        return FlightsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationImage()
        initView()
        initViewModel()
    }
    
    private func initNavigationImage() {
        
        let spaceXImage = UIImageView(image: #imageLiteral(resourceName: "SpaceX_logo"))
        spaceXImage.contentMode = .scaleAspectFit
        navigationItem.titleView = spaceXImage
    }
    
    private func initView() {
        flightsTableView.tableFooterView = UIView()
        flightsTableView.register(cellType: FlighTableViewCell.self)
    }
    
    private func initViewModel() {
        
        flightsViewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.flightsViewModel.alertMessage {
                    let okAction = AlertAction(onSelect: {}, name: "OK", style: .default)
                    let alert = UIAlertController(info: AlertInfo(title: "Error", message: message, actions: [okAction]))
                    self?.present(alert, animated: true)
                }
            }
        }
        
        flightsViewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.flightsViewModel.isLoading ?? false
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                }
            }
        }
        
        flightsViewModel.reloadFlightsTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.flightsTableView.reloadData()
            }
        }
        
        flightsViewModel.initFetch()
    }
}

extension FlightsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return flightsViewModel.numberOfCells
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let flightCell: FlighTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        let cellViewModel = flightsViewModel.getCellViewModel(at: indexPath)
        flightCell.setupCell(viewModel: cellViewModel)
        
        return flightCell
    }
}

extension FlightsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let flightDetailsController = FlightDetailsViewController.instantiate()
        flightDetailsController.setupFlight(flightsViewModel.getFlightDetails(at: indexPath))
        navigationController?.pushViewController(flightDetailsController, animated: true)
    }
}
