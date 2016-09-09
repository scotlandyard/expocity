import UIKit

class MChatItemText:MChatItem
{
    let text:String
    
    init(reusableIdentifier:String, text:String)
    {
        self.text = text
        super.init(reusableIdentifier:reusableIdentifier)
    }
}