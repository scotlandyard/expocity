import UIKit

class MChatItemTextMine:MChatItemText
{
    private let kFontSize:CGFloat = 15
    private let kMarginLeft:CGFloat = 50
    private let kMarginRight:CGFloat = 10
    private let kMarginTop:CGFloat = 10
    private let kMarginBottom:CGFloat = 10
    
    init(text:String)
    {
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        let font:UIFont = UIFont.regular(kFontSize)
        super.init(reusableIdentifier:reusableIdentifier, text:text, font:font, marginLeft:kMarginLeft, marginRight:kMarginRight, marginTop:kMarginTop, marginBottom:kMarginBottom)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        let totalMarginHr:CGFloat = marginLeft + marginRight
        let totalMarginVr:CGFloat = marginTop + marginBottom
        let remainWidth:CGFloat = cellWidth - totalMarginHr
        let maxSize:CGSize = CGSizeMake(remainWidth, kMaxHeight)
        let size:CGSize = attributedString.boundingRectWithSize(
            maxSize,
            options:stringDrawingOptions,
            context:nil)
    }
}