import UIKit

class MChatItemTextMine:MChatItemText
{
    init(text:String)
    {
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        super.init(reusableIdentifier:reusableIdentifier, text:text)
    }
}