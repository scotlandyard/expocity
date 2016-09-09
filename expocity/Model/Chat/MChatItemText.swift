import UIKit

class MChatItemText:MChatItem
{
    let text:String
    let attributedString:NSAttributedString
    
    init(reusableIdentifier:String, text:String, font:UIFont)
    {
        self.text = text
        super.init(reusableIdentifier:reusableIdentifier)
    }
}