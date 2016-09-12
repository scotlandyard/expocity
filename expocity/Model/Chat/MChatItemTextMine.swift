import UIKit

class MChatItemTextMine:MChatItemText
{
    private let kFontSize:CGFloat = 15
    private let kMarginLeft:CGFloat = 60
    private let kMarginRight:CGFloat = 16
    private let kMarginTop:CGFloat = 5
    private let kMarginBottom:CGFloat = 5
    
    init(text:String)
    {
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        let font:UIFont = UIFont.regular(kFontSize)
        super.init(reusableIdentifier:reusableIdentifier, text:text, font:font, marginLeft:kMarginLeft, marginRight:kMarginRight, marginTop:kMarginTop, marginBottom:kMarginBottom)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        let textHeight:CGFloat = textContentHeight()
        
        return textHeight
    }
}