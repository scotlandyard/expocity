import UIKit

class MChatItemTextMine:MChatItemText
{
    fileprivate let kFontSize:CGFloat = 15
    fileprivate let kMarginLeft:CGFloat = 100
    fileprivate let kMarginRight:CGFloat = 12
    fileprivate let kMarginTop:CGFloat = 7
    fileprivate let kMarginBottom:CGFloat = 7
    
    init(text:String)
    {
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        let font:UIFont = UIFont.medium(kFontSize)
        super.init(reusableIdentifier:reusableIdentifier, text:text, font:font, marginLeft:kMarginLeft, marginRight:kMarginRight, marginTop:kMarginTop, marginBottom:kMarginBottom)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        let textHeight:CGFloat = textContentHeight()
        
        return textHeight
    }
}
