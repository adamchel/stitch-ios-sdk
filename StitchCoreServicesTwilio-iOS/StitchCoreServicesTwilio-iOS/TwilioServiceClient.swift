import Foundation
import StitchCore
import StitchCoreServicesTwilio
import StitchCore_iOS

private final class TwilioNamedServiceClientFactory: NamedServiceClientFactory {
    typealias ClientType = TwilioServiceClient
    
    func client(withServiceClient service: StitchServiceClient,
                withClientInfo client: StitchAppClientInfo) -> TwilioServiceClient {
        return TwilioServiceClientImpl(
            withClient: CoreTwilioServiceClient.init(withService: service),
            withDispatcher: OperationDispatcher(withDispatchQueue: DispatchQueue.global())
        )
    }
}

public protocol TwilioServiceClient {
    
    /**
     * Sends an SMS/MMS message.
     *
     * @param to The number to send the message to.
     * @param from The number that the message is from.
     * @param body The body text of the message.
     * @return A task that completes when the send is done.
     */
    func sendMessage(to: String,
                     from: String,
                     body: String,
                     mediaURL: String?,
                     completionHandler: @escaping (Error?) -> Void)
}

public final class TwilioService {
    public static let sharedFactory =
        AnyNamedServiceClientFactory<TwilioServiceClient>(factory: TwilioNamedServiceClientFactory())
}
