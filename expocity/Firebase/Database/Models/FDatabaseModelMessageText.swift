import Foundation

class FDatabaseModelMessageText:FDatabaseModelMessage
{
    let message:String
    private let kEmptyString:String = ""
    
    init(senderId:String, senderName:String, message:String)
    {
        self.message = message
        super.init(senderId:senderId, senderName:senderName)
    }
    
    required init(snapshot:Any?)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        let rawMessage:String? = snapshotDict?[Property.message.rawValue] as? String
        
        if rawMessage == nil
        {
            message = kEmptyString
        }
        else
        {
            message = rawMessage!
        }
        
        super.init(snapshot:snapshot)
    }
}
