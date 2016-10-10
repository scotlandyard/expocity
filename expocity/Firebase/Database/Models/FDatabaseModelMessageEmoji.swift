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
            emoji = Emoji.none
        }
        else
        {
            emoji = Emoji(rawValue:rawEmoji!)!
        }
        
        super.init(snapshot:snapshot)
    }
    
    override func modelJson() -> Any
    {
        var json:[String:Any] = [
            Property.emoji.rawValue:emoji.rawValue
        ]
        
        let parentJson:[String:Any] = super.modelJson() as! [String:Any]
        let parentKeys:[String] = Array(parentJson.keys)
        
        for parentKey:String in parentKeys
        {
            let parentValue:Any = parentJson[parentKey]!
            json[parentKey] = parentValue
        }
        
        return json
    }
}
