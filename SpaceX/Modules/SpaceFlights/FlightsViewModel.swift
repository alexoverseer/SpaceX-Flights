import Foundation

final class FlightsViewModel {
    
    let spaceFlightsAPI: SpaceFlightsProtocol
    
    private var flights: [Flight] = [Flight]()
    
    var selectedFlight: Flight?
    
    var reloadFlightsTableView: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    private var cellViewModels: [FlighTableViewCellViewModel] = [FlighTableViewCellViewModel]() {
        didSet {
            self.reloadFlightsTableView?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    init(api service: SpaceFlightsProtocol = SpaceFlights()) {
        self.spaceFlightsAPI = service
    }
    
    func initFetch() {
        self.isLoading = true
        spaceFlightsAPI.requestFlights(onSuccess: { [weak self] flights in
            self?.isLoading = false
            self?.processFetchedFlights(flights: flights)
        }) { [weak self] error in
            self?.alertMessage = error.message
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FlighTableViewCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func getFlightDetails(at indexPath: IndexPath) -> Flight {
        return self.flights[indexPath.row]
    }
    
    private func processFetchedFlights(flights: [Flight]) {
        
        self.flights = flights
        var vms = [FlighTableViewCellViewModel]()
        for flight in flights {
            vms.append(createCellViewModel(flight: flight))
        }
        self.cellViewModels = vms
    }
    
    func createCellViewModel(flight: Flight) -> FlighTableViewCellViewModel {
        
        return FlighTableViewCellViewModel(missionNameText: flight.missionName,
                                           launchDateText:  formatedFlightDate(flightDate: flight.launchDateUnix).uppercased(),
                                           flightImageUrl:  flight.links.videoLink.youtubePreviewImageURL())
    }
}
