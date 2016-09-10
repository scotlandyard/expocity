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
    let kMaxHeight:CGFloat = 2000
    
    init(reusableIdentifier:String, text:String, font:UIFont, marginLeft:CGFloat, marginRight:CGFloat, marginTop:CGFloat, marginBottom:CGFloat)
    {
        let attributes:[String:AnyObject] = [NSFontAttributeName:font]
        self.text = text
        self.marginLeft = marginLeft
        self.marginRight = marginRight
        self.marginTop = marginTop
        self.marginBottom = marginBottom
        attributedString = NSAttributedString(
            string:text,
            attributes:attributes)
        stringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.UsesLineFragmentOrigin,
            NSStringDrawingOptions.UsesFontLeading
        ])
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}