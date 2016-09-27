import UIKit

class MChatItemEmojiMine:MChatItemEmoji
{
    init(image:UIImage)
    {
        
    }
    
    override func heightForCurrentWidth() -> CGFloat
    {
        return kImageHeight
    }
}
