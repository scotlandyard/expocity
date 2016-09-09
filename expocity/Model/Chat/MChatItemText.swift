import UIKit

class MChatItemText:MChatItem
{
    let text:String
    let attributedString:NSAttributedString
    
    init(reusableIdentifier:String, text:String, font:UIFont)
    {
        let attributes:[String:AnyObject] = [NSFontAttributeName:font]
        self.text = text
        attributedString = NSAttributedString(
            string:text,
            attributes:attributes)
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}