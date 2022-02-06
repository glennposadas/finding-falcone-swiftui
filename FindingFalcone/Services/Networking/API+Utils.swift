import Foundation

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
   Internal function to execute a URLRequest and to process and return an Array that has been constructed from JSON data
   */
  func processArrayRequest(_ request: URLRequest,
                           debugName: String,
                           throttleConnections: Bool,
                           completionHandler: @escaping (_ result: NSArray?, _ error: NSError?) -> Void) {
    // Call the server
    var urlSession = URLSession.shared
    if throttleConnections {
      urlSession = API.shared.sharedThrottledURLSession()
    }
    
    urlSession.dataTask(with: request) { data, response, error in
      if let error = error {
        print("\(debugName) \(error.localizedDescription)")
        completionHandler(nil, error as NSError)
        return
      }
      
      if let data = data { // convert the response, which should be in JSON format, to an NSArray
        do {
          if let convertedArray = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
            completionHandler(convertedArray, nil)
          } else {
            completionHandler(nil, self.createError(message: "\(debugName) unable to convert JSON to array", response: response))
          }
        } catch let error {
          print("\(debugName) \(error.localizedDescription)")
          completionHandler(nil, error as NSError)
        }
      } else {
        completionHandler(nil, self.createError(message: debugName, response: response))
      }
    }.resume()
  }
  
  /**
   Internal function to execute a URLRequest and to process and return a Dictionary that has been constructed from JSON data
   */
  func processDictionaryRequest(_ request: URLRequest, debugName: String, throttleConnections: Bool,
                                completionHandler: @escaping (_ result: [String : Any]?, _ error: NSError?) -> Void) {
    // Call the server
    var urlSession = URLSession.shared
    if throttleConnections {
      urlSession = API.shared.sharedThrottledURLSession()
    }
    
    urlSession.dataTask(with: request) { data, response, error in
      if let error = error {
        print("\(debugName) \(error.localizedDescription)")
        completionHandler(nil, error as NSError)
        return
      }
      
      if let data = data { // convert the response, which should be in JSON format, to an NSArray
        do {
          if let convertedDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
            completionHandler(convertedDic, nil)
          } else {
            completionHandler(nil, self.createError(message: "\(debugName) unable to convert JSON to dictionary", response: response))
          }
        } catch let error {
          print("\(debugName) \(error.localizedDescription)")
          completionHandler(nil, error as NSError)
        }
      } else {
        completionHandler(nil, self.createError(message: debugName, response: response))
      }
    }.resume()
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
