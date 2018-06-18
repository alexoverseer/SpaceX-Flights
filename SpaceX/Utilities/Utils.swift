import Alamofire

var isReachable: Bool {
    return (NetworkReachabilityManager()?.isReachable) ?? false
}

func formatFlightDate(flightDate: Double) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE dd, yyyy"
    let date = Date(timeIntervalSince1970: flightDate)
    
    return dateFormatter.string(from: date)
}
