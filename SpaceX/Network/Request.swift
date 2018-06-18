import Foundation
import Alamofire

private let baseAPI = "https://api.spacexdata.com/v2/"

enum Encoding {
    case string
    case json
}

struct RequestInputs {
    let params: [String: Any]?
    let path: String
    let method: Alamofire.HTTPMethod
    let onSuccess: (Any?) -> Void
    let onFailure: (ErrorType) -> Void
    
    init(params: [String: Any]? = nil,
         path: String,
         method: Alamofire.HTTPMethod = .get,
         onSuccess: @escaping (Any?) -> Void,
         onFailure: @escaping (ErrorType) -> Void) {
        self.params = params
        self.path = path
        self.method = method
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
}

struct Request {
    init(inputs: RequestInputs, encoding: Encoding) {
        if !isReachable {
            inputs.onFailure(.connection)
            
            return
        }
        guard let url = URL(string: baseAPI) else {
            inputs.onFailure(.undefined)
            
            return
        }
        switch encoding {
        case .string: stringRequest(with: inputs, url: url)
        case .json: jsonRequest(with: inputs, url: url)
        }
    }
    
    private func stringRequest(with inputs: RequestInputs, url: URL) {
        
        Alamofire.request(url.appendingPathComponent(inputs.path),
                          method: inputs.method,
                          parameters: inputs.params,
                          encoding: JSONEncoding.default).responseString(completionHandler: { (response) in
                            switch response.result {
                            case .success: inputs.onSuccess(response.value)
                            case .failure: inputs.onFailure(.request(response.error))
                            }
                          })
    }
    
    private func jsonRequest(with inputs: RequestInputs, url: URL) {
        Alamofire.request(url.appendingPathComponent(inputs.path),
                          method: inputs.method,
                          parameters: inputs.params,
                          encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                            switch response.result {
                            case .success: inputs.onSuccess(response.value)
                            case .failure: inputs.onFailure(.request(response.error))
                            }
                          })
    }
}
