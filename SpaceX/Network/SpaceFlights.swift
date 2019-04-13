import Foundation

protocol SpaceFlightsProtocol {
    func fetchFlights(result: @escaping (Result<[Flight], ErrorType>) -> Void)
}

struct SpaceFlights: SpaceFlightsProtocol {
    
    func fetchFlights(result: @escaping (Result<[Flight], ErrorType>) -> Void) {
        let onRequestSuccess: (Result<Any?, ErrorType>) -> Void = { response in
            switch response {
            case .success(let data):
                guard let stringResponse = data as? String,
                    let jsonData = stringResponse.data(using: .utf8) else {
                        return result(.failure(.responseParse))
                }
                
                do {
                    var flights = try JSONDecoder().decode([Flight].self, from: jsonData)
                    flights.reverse()
                    result(.success(flights))
                } catch let error {
                    print(error)
                    result(.failure(.responseParse))
                }
            case .failure(let error):
                result(.failure(.request(error)))
            }
        }
        let inputs = RequestInputs(path: "launches", result: onRequestSuccess)
        _ = Request(inputs: inputs)
    }
}
