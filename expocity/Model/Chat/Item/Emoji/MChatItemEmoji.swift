import UIKit

class MChatItemEmoji:MChatItem
{
    let image:UIImage
    private let kHeight:CGFloat = 50
    
    init(image:UIImage)
    {
        self.image = image
        let reusableIdentifier:String = VChatConversationCellTextMine.reusableIdentifier()
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        let textHeight:CGFloat = textContentHeight()
        
        return textHeight
    }
}
