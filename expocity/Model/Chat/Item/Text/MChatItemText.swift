import UIKit

class MChatItemText:MChatItem
{
    let text:String
    let attributedString:NSAttributedString
    let stringDrawingOptions:NSStringDrawingOptions
    let marginLeft:CGFloat
    let marginRight:CGFloat
    let marginTop:CGFloat
    let marginBottom:CGFloat
    let kMaxHeight:CGFloat = 3000
    var contentWidth:CGFloat
    var contentHeight:CGFloat
    var extraMargin:CGFloat
    
    init(reusableIdentifier:String, text:String, font:UIFont, marginLeft:CGFloat, marginRight:CGFloat, marginTop:CGFloat, marginBottom:CGFloat)
    {
        let attributes:[String:AnyObject] = [NSFontAttributeName:font]
        self.text = text
        self.marginLeft = marginLeft
        self.marginRight = marginRight
        self.marginTop = marginTop
        self.marginBottom = marginBottom
        extraMargin = 0
        contentWidth = 0
        contentHeight = 0
        attributedString = NSAttributedString(
            string:text,
            attributes:attributes)
        stringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading
        ])
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
    
    //MARK: public
    
    func textContentHeight() -> CGFloat
    {
        let totalMarginHr:CGFloat = marginLeft + marginRight
        let totalMarginVr:CGFloat = marginTop + marginBottom
        let remainWidth:CGFloat = cellWidth - totalMarginHr
        let maxSize:CGSize = CGSize(width:remainWidth, height:kMaxHeight)
        let rect:CGRect = attributedString.boundingRect(
            with: maxSize,
            options:stringDrawingOptions,
            context:nil)
        let size:CGSize = rect.size
        let totalWidth:CGFloat = ceil(size.width)
        let textHeight:CGFloat = ceil(size.height)
        contentWidth = totalWidth
        contentHeight = textHeight
        let totalHeight:CGFloat = contentHeight + totalMarginVr
        
        if totalWidth < remainWidth
        {
            extraMargin = remainWidth - totalWidth
        }
        else
        {
            extraMargin = 0
        }
        
        return totalHeight
    }
}
