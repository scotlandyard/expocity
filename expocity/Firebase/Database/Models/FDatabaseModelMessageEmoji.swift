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
