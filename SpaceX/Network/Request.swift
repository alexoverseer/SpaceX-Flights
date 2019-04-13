import Alamofire
import Foundation

private let baseAPI = "https://api.spacexdata.com/v2/"

struct RequestInputs {
    let params: [String: Any]?
    let path: String
    let method: Alamofire.HTTPMethod
    let result: (Swift.Result<Any?, ErrorType>) -> Void
    
    init(params: [String: Any]? = nil,
         path: String,
         method: Alamofire.HTTPMethod = .get,
         result: @escaping (Swift.Result<Any?, ErrorType>) -> Void) {
        self.params = params
        self.path = path
        self.method = method
        self.result = result
    }
}

struct Request {
    init(inputs: RequestInputs) {
        if !isReachable {
            inputs.result(.failure(.connection))
            
            return
        }
        guard let url = URL(string: baseAPI) else {
            inputs.result(.failure(.undefined))
            
            return
        }
        
        executeRequest(with: inputs, url: url)
    }
    
    private func executeRequest(with inputs: RequestInputs, url: URL) {
        
        Alamofire.request(url.appendingPathComponent(inputs.path),
                          method: inputs.method,
                          parameters: inputs.params,
                          encoding: JSONEncoding.default).responseString(completionHandler: { (response) in
                            switch response.result {
                            case .success: inputs.result(.success(response.value))
                            case .failure: inputs.result(.failure(.request(response.error)))
                            }
                          })
    }
}
