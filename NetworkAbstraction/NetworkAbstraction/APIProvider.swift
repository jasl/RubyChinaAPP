//
// Created by 姜军 on 12/14/15.
// Copyright (c) 2015 RubyChina. All rights reserved.
//

import Foundation
import Alamofire

// Closure to be executed when a request has completed.
public typealias Completion = (result: Result<NetworkAbstraction.Response, NetworkAbstraction.Error>) -> ()

// Represents an HTTP method.
public enum Method: String {
    case GET, POST, PUT, DELETE, OPTIONS, HEAD, PATCH, TRACE, CONNECT
}

// Choice of parameter encoding.
public enum ParameterEncoding {
    case URL
    case JSON
    case PropertyList(NSPropertyListFormat, NSPropertyListWriteOptions)
    case Custom((URLRequestConvertible, [String: AnyObject]?) -> (NSMutableURLRequest, NSError?))

    internal var toAlamofire: Alamofire.ParameterEncoding {
        switch self {
        case .URL:
            return .URL
        case .JSON:
            return .JSON
        case .PropertyList(let format, let options):
            return .PropertyList(format, options)
        case .Custom(let closure):
            return .Custom(closure)
        }
    }
}

public protocol TargetType {
    var baseURL: NSURL { get }
    var path: String { get }
    var method: NetworkAbstraction.Method { get }
    var parameters: [String: AnyObject]? { get }
}

// Protocol to define the opaque type returned from a request
public protocol Cancellable {
    func cancel()
}

// Request provider class. Requests should be made through this class only.
public class APIProvider {

    // Closure that defines the endpoints for the provider.
    public typealias EndpointClosure = TargetType -> Endpoint

    // Closure that resolves an Endpoint into an NSURLRequest.
    public typealias RequestClosure = (Endpoint, NSURLRequest -> Void) -> Void

    public let endpointClosure: EndpointClosure
    public let requestClosure: RequestClosure
    public let manager: Manager

    // A list of plugins
    // e.g. for logging, network activity indicator or credentials
    public let plugins: [PluginType]

    // Initializes a provider.
    public init(endpointClosure: EndpointClosure = APIProvider.DefaultEndpointMapping,
                requestClosure: RequestClosure = APIProvider.DefaultRequestMapping,
                manager: Manager = Alamofire.Manager.sharedInstance,
                plugins: [PluginType] = []) {

        self.endpointClosure = endpointClosure
        self.requestClosure = requestClosure
        self.manager = manager
        self.plugins = plugins
    }

    // Returns an Endpoint based on the token, method, and parameters by invoking the endpointsClosure.
    public func endpoint(token: TargetType) -> Endpoint {
        return endpointClosure(token)
    }

    // Designated request-making method. Returns a Cancellable token to cancel the request later.
    public func request(target: TargetType, completion: NetworkAbstraction.Completion) -> Cancellable {
        let endpoint = self.endpoint(target)
        var cancellableToken = CancellableWrapper()

        let performNetworking = { (request: NSURLRequest) in
            if cancellableToken.isCancelled { return }

            cancellableToken.innerCancellable = self.sendRequest(target, request: request, completion: completion)
        }

        requestClosure(endpoint, performNetworking)

        return cancellableToken
    }
}

// Mark: Defaults

public extension APIProvider {

    // These functions are default mappings to endpoings and requests.

    public final class func DefaultEndpointMapping(target: TargetType) -> Endpoint {
        let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
        return Endpoint(URL: url, method: target.method, parameters: target.parameters)
    }

    public final class func DefaultRequestMapping(endpoint: Endpoint, closure: NSURLRequest -> Void) {
        return closure(endpoint.urlRequest)
    }
}

internal extension APIProvider {

    func sendRequest(target: TargetType, request: NSURLRequest, completion: NetworkAbstraction.Completion) -> CancellableToken {
        let request = manager.request(request)
        let plugins = self.plugins

        // Give plugins the chance to alter the outgoing request
        plugins.forEach { $0.willSendRequest(request, target: target) }

        // Perform the actual request
        let alamoRequest = request.response { (_, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> () in
            let result = convertResponseToResult(response, data: data, error: error)
            // Inform all plugins about the response
            plugins.forEach { $0.didReceiveResponse(result, target: target) }
            completion(result: result)
        }

        return CancellableToken(request: alamoRequest)
    }
}

private func convertResponseToResult(response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> NetworkAbstraction.Result<NetworkAbstraction.Response, NetworkAbstraction.Error> {
    switch (response, data, error) {
    case let (.Some(response), .Some(data), .None):
        let response = NetworkAbstraction.Response(statusCode: response.statusCode, data: data, response: response)
        return NetworkAbstraction.Result(success: response)
    case let (.None, .None, .Some(error)):
        let error = NetworkAbstraction.Error.Underlying(error)
        return NetworkAbstraction.Result(failure: error)
    default:
        let error = NetworkAbstraction.Error.Underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
        return NetworkAbstraction.Result(failure: error)
    }
}

// Internal token that can be used to cancel requests
internal final class CancellableToken: Cancellable , CustomDebugStringConvertible{
    let cancelAction: () -> Void
    let request : Request?
    private(set) var canceled: Bool = false

    private var lock: OSSpinLock = OS_SPINLOCK_INIT

    func cancel() {
        OSSpinLockLock(&lock)
        defer { OSSpinLockUnlock(&lock) }
        guard !canceled else { return }
        canceled = true
        cancelAction()
    }

    init(action: () -> Void){
        self.cancelAction = action
        self.request = nil
    }

    init(request : Request){
        self.request = request
        self.cancelAction = {
            request.cancel()
        }
    }

    var debugDescription: String {
        guard let request = self.request else {
            return "Empty Request"
        }
        return request.debugDescription
    }

}

private struct CancellableWrapper: Cancellable {
    var innerCancellable: CancellableToken? = nil

    private var isCancelled = false

    func cancel() {
        innerCancellable?.cancel()
    }
}

// Make the Alamofire Request type conform to our type, to prevent leaking Alamofire to plugins.
extension Request: RequestType { }
