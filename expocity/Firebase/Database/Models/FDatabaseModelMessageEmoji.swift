import Foundation

class FDatabaseModelMessageEmoji:FDatabaseModelMessage
{
    let emoji:Emoji

    enum Emoji:Int
    {
        case none = 0
        case like = 1
        case love = 2
        case smile = 3
        case sad = 4
        case angry = 5
        case surprise = 6
    }
    
    init(senderId:String, senderName:String, emoji:Emoji)
    {
        self.emoji = emoji
        super.init(senderId:senderId, senderName:senderName)
    }
    
    required init(snapshot:Any?)
    {
        let snapshotDict:[String:Any]? = snapshot as? [String:Any]
        let rawEmoji:Int? = snapshotDict?[Property.emoji.rawValue] as? Int
        
        if rawEmoji == nil
        {
            emoji = kEmptyString
        }
        else
        {
            message = rawMessage!
        }
        
        super.init(snapshot:snapshot)
    }
}
