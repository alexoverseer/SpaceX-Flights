import Foundation

final class FlightsViewModel {
    
    let spaceFlightsAPI: SpaceFlightsProtocol
    
    private var flights: [Flight] = [Flight]()
    
    var reloadFlightsTableView: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
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
        }, onFailure: { [weak self] error in
            self?.isLoading = false
            self?.alertMessage = error.message
        })
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FlighTableViewCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func getFlightDetails(at indexPath: IndexPath) -> Flight {
        return self.flights[indexPath.row]
    }
    
    private func processFetchedFlights(flights: [Flight]) {
        
        self.flights = flights
        var flighViewModels = [FlighTableViewCellViewModel]()
        flighViewModels = flights.map {createCellViewModel(flight: $0)}
        self.cellViewModels = flighViewModels
    }
    
    func createCellViewModel(flight: Flight) -> FlighTableViewCellViewModel {
        
        return FlighTableViewCellViewModel(missionNameText: flight.missionName,
                                           launchDateText: formatedFlightDate(flightDate: flight.launchDateUnix).uppercased(),
                                           flightImageUrl: flight.links.videoLink.youtubePreviewImageURL())
    }
}
