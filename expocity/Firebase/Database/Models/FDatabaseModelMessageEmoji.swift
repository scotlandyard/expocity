import Foundation

class FDatabaseModelMessageEmoji:FDatabaseModelMessage
{
    let emoji:Emoji

    enum Emoji:Int
    {
        case like = 0
        case love = 1
        case smile = 2
        case sad = 3
        case angry = 4
        case surprise = 5
    }
    
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
