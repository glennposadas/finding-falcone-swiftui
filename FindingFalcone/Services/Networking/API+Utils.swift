import Foundation

enum NetworkingError: Error {
  case invalidType(Error, Data?)
}

extension API {
  /**
   Create a URLSession pre-configured for use. The API strictly requires appropriate HTTP headers.
   
   - Parameter urlPath: String URL path to the endpoint for this request
   
   - Returns: A newly created URLSession object configured for use with the API
   */
  func createRequest(urlPath: String) -> URLRequest {
    // Create the configured URLRequest and return
    var request = URLRequest(url: URL(string: urlPath)!)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
  }
  
  /**
   Process a request generically
   */
  func processRequest<T: Decodable>(_ request: URLRequest,
                                    debugName: String,
                                    throttleConnections: Bool,
                                    completion: @escaping (Result<T, Error>) -> Void) {
    // Call the server
    var urlSession = URLSession.shared
    if throttleConnections {
      urlSession = API.shared.sharedThrottledURLSession()
    }
    
    urlSession.dataTask(with: request) { data, response, error in
      if let error = error {
        print("\(debugName) \(error.localizedDescription)")
        completion(.failure(error))
        return
      }
      
      if let data = data {
        return self.handleResult(.success(data), completion: completion)
      } else {
        completion(.failure(self.createError(message: debugName, response: response)))
      }
    }.resume()
  }
  
  /**
   Handle a result generically.
   */
  func handleResult<T: Decodable>(
    _ result: Result<Data, Error>,
    function: String = #function,
    completion: @escaping (Result<T, Error>) -> Void) {
      DispatchQueue.main.async {
        switch result {
        case .success(let data):
          do {
            let dto = try JSONDecoder().decode(T.self, from: data)
            print("API: \(function) - Success \(function): \(dto)")
            print("======== BEGIN DUMP ========")
            dump(dto)
            print("======== END DUMP ========")
            completion(.success(dto))
          } catch let error {
            print("API: \(function) - Error \(function): \(error.localizedDescription) | Error code: \((error as NSError).code) | response: \(String(describing: String.init(data: data, encoding: .utf8)))")
            completion(.failure(NetworkingError.invalidType(error, data)))
          }
        case .failure(let error):
          print("API: \(function) - Failure \(function): \(error.localizedDescription)")
          completion(.failure(error))
        }
      }
    }
  
  /**
   Create a custom NSError to return error messages to the caller
   */
  func createError(message: String, response: URLResponse?) -> NSError {
    var statusCode = 0
    var userInfo: [String : Any] = [
      NSLocalizedDescriptionKey :  NSLocalizedString("Error", value: message, comment: "") ,
      NSLocalizedFailureReasonErrorKey : NSLocalizedString("Error", value: message, comment: "")
    ]
    if let httpResponse = response as? HTTPURLResponse {
      statusCode = httpResponse.statusCode
      userInfo = [
        NSLocalizedDescriptionKey : NSLocalizedString("Error", value:HTTPURLResponse.localizedString(forStatusCode: statusCode), comment: "message") ,
        NSLocalizedFailureReasonErrorKey : NSLocalizedString("Error", value:HTTPURLResponse.localizedString(forStatusCode: statusCode), comment: "message") ,
      ]
      
    }
    return NSError(domain: "APIError-FindingFalcone", code: statusCode, userInfo: userInfo)
  }
}
