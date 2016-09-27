import UIKit

class VChatConversationCellEmojiMine:VChatConversationCellEmoji
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        imageView.contentMode = UIViewContentMode.right
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
