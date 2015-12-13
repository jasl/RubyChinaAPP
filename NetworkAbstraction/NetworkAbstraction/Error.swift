import Foundation

public enum Error: ErrorType {
    case ImageMapping(Response)
    case JSONMapping(Response)
    case StringMapping(Response)
    case StatusCode(Response)
    case Data(Response)
    case Underlying(ErrorType)
}
