import UIKit

class MChatItemEmojiMine:MChatItemEmoji
{
    init(image:UIImage)
    {
        let reusableIdentifier:String = VChatConversationCellEmojiMine.reusableIdentifier()
        
        super.init(image:image, reusableIdentifier:reusableIdentifier)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        return kImageHeight
    }
}
