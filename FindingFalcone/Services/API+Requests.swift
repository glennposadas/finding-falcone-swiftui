import Foundation

extension API {
  /**
   Make a request to the server for the api token.
   */
  func getToken() async -> Result<Dictionary<String, Any>, Error> {
    let urlPath = API.baseURLPath + "token"
    var request = createRequest(urlPath: urlPath)
    request.httpMethod = "POST"
    
    return await withCheckedContinuation { continuation in
      processDictionaryRequest(request,
                               debugName: "get token",
                               throttleConnections: true) { dictionary, error in
        if let dictionary = dictionary {
          continuation.resume(returning: .success(dictionary))
        } else {
          continuation.resume(returning: .failure(error!))
        }
      }
    }
  }
}
