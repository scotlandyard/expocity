import Foundation

class FDatabaseModelMessage:FDatabaseModel
{
    let senderId:String
    let senderName:String
    let message:String
    let timestamp:TimeInterval
    
    enum Property:String
    {
        case senderId = "senderId"
        case senderName = "senderName"
        case message = "message"
        case timestamp = "timestamp"
    }
    
    init(senderId:String, senderName:String, message:String)
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
        
        if rawIntAccess == nil
        {
            access = Access.unknown
        }
        else
        {
            let rawAccess:Access? = Access(rawValue:rawIntAccess!)
            
            if rawAccess == nil
            {
                access = Access.unknown
            }
            else
            {
                access = rawAccess!
            }
        }
        
        if rawIntPresentation == nil
        {
            presentation = Presentation.unknown
        }
        else
        {
            let rawPresentation:Presentation? = Presentation(rawValue:rawIntPresentation!)
            
            if rawPresentation == nil
            {
                presentation = Presentation.unknown
            }
            else
            {
                presentation = rawPresentation!
            }
        }
        
        if rawName == nil
        {
            name = kEmptyString
        }
        else
        {
            name = rawName!
        }
        
        if rawOwner == nil
        {
            owner = kEmptyString
        }
        else
        {
            owner = rawOwner!
        }
        
        if rawCreated == nil
        {
            created = kNonCreated
        }
        else
        {
            created = rawCreated!
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
