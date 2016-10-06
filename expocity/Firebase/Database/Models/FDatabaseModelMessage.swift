import Foundation

class FDatabaseModelMessage:FDatabaseModel
{
    let senderId:String
    let senderName:String
    let timestamp:TimeInterval
    private let kEmptyString:String = ""
    private let kNoTimestamp:TimeInterval = 0
    
    enum Property:String
    {
        case senderId = "senderId"
        case senderName = "senderName"
        case message = "message"
        case emoji = "emoji"
        case timestamp = "timestamp"
    }
    
    init(senderId:String, senderName:String)
    {
        self.senderId = senderId
        self.senderName = senderName
        self.message = message
        timestamp = NSDate().timeIntervalSince1970
        
        super.init()
    }
    
    required init(snapshot:Any?)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        let rawSenderId:String? = snapshotDict?[Property.senderId.rawValue] as? String
        let rawSenderName:String? = snapshotDict?[Property.senderName.rawValue] as? String
        let rawMessage:String? = snapshotDict?[Property.message.rawValue] as? String
        let rawTimestamp:TimeInterval? = snapshotDict?[Property.timestamp.rawValue] as? TimeInterval
        
        if rawSenderId == nil
        {
            senderId = kEmptyString
        }
        else
        {
            senderId = rawSenderId!
        }
        
        if rawSenderName == nil
        {
            senderName = kEmptyString
        }
        else
        {
            senderName = rawSenderName!
        }
        
        if rawMessage == nil
        {
            message = kEmptyString
        }
        else
        {
            message = rawMessage!
        }
        
        if rawTimestamp == nil
        {
            timestamp = kNoTimestamp
        }
        else
        {
            timestamp = rawTimestamp!
        }
        
        super.init()
    }
    
    override func modelJson() -> Any
    {
        let json:[String:Any] = [
            Property.senderId.rawValue:senderId,
            Property.senderName.rawValue:senderName,
            Property.message.rawValue:message,
            Property.timestamp.rawValue:timestamp,
        ]
        
        return json
    }
}
