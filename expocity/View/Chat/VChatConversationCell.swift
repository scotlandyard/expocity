import UIKit

class VChatConversationCell:UICollectionViewCell
{
    weak var labelContent:UILabel!
    weak var bubbleContent:UIView!
    private let kBubbleCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let labelContent:UILabel = UILabel()
        labelContent.backgroundColor = UIColor.clearColor()
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.userInteractionEnabled = false
        labelContent.numberOfLines = 0
        self.labelContent = labelContent
        
        let bubbleContent:UIView = UIView()
        bubbleContent.clipsToBounds = true
        bubbleContent.translatesAutoresizingMaskIntoConstraints = false
        bubbleContent.userInteractionEnabled = false
        bubbleContent.layer.cornerRadius = kBubbleCornerRadius
        self.bubbleContent = bubbleContent
        
        bubbleContent.addSubview(labelContent)
        addSubview(bubbleContent)
        
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MChatItem, controller:CChat)
    {
        
    }
}