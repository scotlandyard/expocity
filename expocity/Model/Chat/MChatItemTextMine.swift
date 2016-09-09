import UIKit

class MChatItemTextMine:MChatItemText
{
    private let kFontSize:CGFloat = 15
    
    init(text:String)
    {
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        let font:UIFont = UIFont.regular(kFontSize)
        super.init(reusableIdentifier:reusableIdentifier, text:text, font:font)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        let
    }
}