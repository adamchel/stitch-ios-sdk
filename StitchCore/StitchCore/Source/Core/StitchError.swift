import Foundation

/// Network errors in response from the Stitch servers.
public enum StitchError: Error {
    /// Reasons why the server may fail that contain more precise messaging.
    public enum ServerErrorReason {
        /// Session was no longer valid
        case invalidSession(message: String)
        /// Domain was not allowd
        case domainNotAllowed(message: String)
        /// Stage used required another stage before it in order to function properly
        case stageSourceRequired(message: String)
        /// Invalid parameter passed to server
        case invalidParameter(message: String)
        /// Error with twilio service
        case twilioError(message: String)
        /// Error with pubnub
        case pubNubError(message: String)
        /// Standard http error
        case httpError(message: String)
        /// Error with Amazon Web Services
        case awsError(message: String)
        /// Error with MongoDB service
        case mongoDBError(message: String)
        /// Error with Slack service
        case slackError(message: String)
        /// Requested provided was not found
        case authProviderNotFound(message: String)
        /// No rule in the app was found
        case noMatchingRuleFound(message: String)
        /// Misc errors
        case other(message: String)
        
        internal var isInvalidSession: Bool {
            switch self {
            case .invalidSession:
                return true
            default:
                return false
            }
        }
        
        /**
             Create a new `StitchError`.
 
             - Parameters:
                 - errorCode: String based error code that should coincide with `ServerErrorReason`
                 - errorMessage: More precise error message
         */
        init(errorCode: String, errorMessage: String) {
            switch errorCode {
            case "InvalidSession":
                self = .invalidSession(message: errorMessage)
                break
            case "DomainNotAllowed":
                self = .domainNotAllowed(message: errorMessage)
                break
            case "StageSourceRequired":
                self = .stageSourceRequired(message: errorMessage)
                break
            case "InvalidParameter":
                self = .invalidParameter(message: errorMessage)
                break
            case "TwilioError":
                self = .twilioError(message: errorMessage)
                break
            case "PubNubError":
                self = .pubNubError(message: errorMessage)
                break
            case "HTTPError":
                self = .httpError(message: errorMessage)
                break
            case "AWSError":
                self = .awsError(message: errorMessage)
                break
            case "MongoDBError":
                self = .mongoDBError(message: errorMessage)
                break
            case "SlackError":
                self = .slackError(message: errorMessage)
                break
            case "AuthProviderNotFound":
                self = .authProviderNotFound(message: errorMessage)
                break
            case "NoMatchingRuleFound":
                self = .noMatchingRuleFound(message: errorMessage)
                break
                
            default:
                self = .other(message: errorMessage)
            }
        }
    }
    
    /// General server error
    case serverError(reason: ServerErrorReason)
    /// Failed pasing a response
    case responseParsingFailed(reason: String)
    /// Not authorized to make this action
    case unauthorized(message: String)
    /// This action was illegal
    case illegalAction(message: String)
    /// StitchClient has already been released
    case clientReleased
}


// MARK: - Error Descriptions

extension StitchError: LocalizedError {
    /// String describing this error
    public var errorDescription: String? {
        switch self {
        case .responseParsingFailed(let reason):
            return reason
        case .serverError(let reason):
            return reason.errorDescription
        case .unauthorized(let message):
            return message
        case .illegalAction(let message):
            return message
        case .clientReleased:
            return "StitchClient was released while performing the task."
        }
    }
}

extension StitchError.ServerErrorReason: LocalizedError {
    /// String describing this error
    public var errorDescription: String? {
        switch self {
        case .invalidSession(let message):
            return message
        case .domainNotAllowed(let message):
            return message
        case .stageSourceRequired(let message):
            return message
        case .invalidParameter(let message):
            return message
        case .twilioError(let message):
            return message
        case .pubNubError(let message):
            return message
        case .httpError(let message):
            return message
        case .awsError(let message):
            return message
        case .mongoDBError(let message):
            return message
        case .slackError(let message):
            return message
        case .authProviderNotFound(let message):
            return message
        case .noMatchingRuleFound(let message):
            return message
        case .other(let message):
            return message
        }
    }
}
