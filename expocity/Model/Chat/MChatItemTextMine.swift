import UIKit

class MChatItemTextMine:MChatItemText
{
    private let kFontSize:CGFloat = 15
    private let kMarginLeft:CGFloat = 50
    private let kMarginRight:CGFloat = 10
    
    init(text:String)
    {
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        let font:UIFont = UIFont.regular(kFontSize)
        super.init(reusableIdentifier:reusableIdentifier, text:text, font:font, marginLeft:kMarginLeft, marginRight:kMarginRight)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        let
        let maxSize:CGSize = CGSizeMake(<#T##width: CGFloat##CGFloat#>, kMaxHeight)
        let size:CGSize = attributedString.boundingRectWithSize(
            <#T##size: CGSize##CGSize#>, options: <#T##NSStringDrawingOptions#>, context: <#T##NSStringDrawingContext?#>)
    }
}