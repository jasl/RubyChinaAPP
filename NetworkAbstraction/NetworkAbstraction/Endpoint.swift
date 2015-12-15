import Foundation
import Alamofire

public class Endpoint {
    public let URL: String
    public let method: NetworkAbstraction.Method
    public let parameters: [String: AnyObject]?
    public let parameterEncoding: ParameterEncoding
    public let httpHeaderFields: [String: String]?

    // Main initializer for Endpoint.
    public init(URL: String,
        method: NetworkAbstraction.Method = NetworkAbstraction.Method.GET,
        parameters: [String: AnyObject]? = nil,
        parameterEncoding: NetworkAbstraction.ParameterEncoding = .URL,
        httpHeaderFields: [String: String]? = nil) {

        self.URL = URL
        self.method = method
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
        self.httpHeaderFields = httpHeaderFields
    }

    // Convenience method for creating a new Endpoint with the same properties as the receiver, but with added parameters.
    public func endpointByAddingParameters(parameters: [String: AnyObject]) -> Endpoint {
        var newParameters = self.parameters ?? [String: AnyObject]()
        for (key, value) in parameters {
            newParameters[key] = value
        }

        return Endpoint(URL: URL, method: method, parameters: newParameters, parameterEncoding: parameterEncoding, httpHeaderFields: httpHeaderFields)
    }

    // Convenience method for creating a new Endpoint with the same properties as the receiver, but with added HTTP header fields.
    public func endpointByAddingHTTPHeaderFields(httpHeaderFields: [String: String]) -> Endpoint {
        var newHTTPHeaderFields = self.httpHeaderFields ?? [String: String]()
        for (key, value) in httpHeaderFields {
            newHTTPHeaderFields[key] = value
        }

        return Endpoint(URL: URL, method: method, parameters: parameters, parameterEncoding: parameterEncoding, httpHeaderFields: newHTTPHeaderFields)
    }

    // Convenience method for creating a new Endpoint with the same properties as the receiver, but with another parameter encoding.
    public func endpointByAddingParameterEncoding(newParameterEncoding: NetworkAbstraction.ParameterEncoding) -> Endpoint {
        return Endpoint(URL: URL, method: method, parameters: parameters, parameterEncoding: newParameterEncoding, httpHeaderFields: httpHeaderFields)
    }
}

// Extension for converting an Endpoint into an NSURLRequest.
extension Endpoint {
    public var urlRequest: NSURLRequest {
        return mutableURLRequest
    }

    public var mutableURLRequest: NSMutableURLRequest {
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URL)!)
        request.HTTPMethod = method.rawValue
        request.allHTTPHeaderFields = httpHeaderFields

        return parameterEncoding.toAlamofire.encode(request, parameters: parameters).0
    }
}

// Required for making Endpoint conform to Equatable.
public func ==(lhs: Endpoint, rhs: Endpoint) -> Bool {
    return lhs.urlRequest.isEqual(rhs.urlRequest)
}

// Required for using Endpoint as a key type in a Dictionary.
extension Endpoint: Equatable, Hashable {
    public var hashValue: Int {
        return urlRequest.hash
    }
}
