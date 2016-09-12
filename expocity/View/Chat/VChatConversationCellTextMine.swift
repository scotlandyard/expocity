import UIKit

class VChatConversationCellTextMine:VChatConversationCellText
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        bubbleContent.backgroundColor = UIColor.complement()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}