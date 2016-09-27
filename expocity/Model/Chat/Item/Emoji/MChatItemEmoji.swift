import UIKit

class MChatItemEmoji:MChatItem
{
    let image:UIImage
    let kImageHeight:CGFloat = 50
    
    init(image:UIImage, reusableIdentifier:String)
    {
        self.image = image
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}
