import Foundation

struct SpaceFlights {
    
    func requestFlights(onSuccess: @escaping ([Flight]) -> Void, onFailure: @escaping (ErrorType) -> Void) {
        let onRequestSuccess: (Any?) -> Void = { response in
            guard let stringResponse = response as? String,
                let jsonData = stringResponse.data(using: .utf8) else {
                    return onFailure(.responseParse)
            }
            
            do {
                let flights = try JSONDecoder().decode([Flight].self, from: jsonData)
                onSuccess(flights)
            } catch let error {
                print(error)
                onFailure(.responseParse)
            }
        }
        let inputs = RequestInputs(path: "launches", onSuccess: onRequestSuccess, onFailure: onFailure)
        _ = Request(inputs: inputs, encoding: .string)
    }
}
