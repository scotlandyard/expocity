import UIKit

class VChatConversationCellText:VChatConversationCell
{
    weak var labelContent:UILabel!
    weak var bubbleContent:UIView!
    weak var layoutBubbleTop:NSLayoutConstraint!
    weak var layoutBubbleBottom:NSLayoutConstraint!
    weak var layoutBubbleLeft:NSLayoutConstraint!
    weak var layoutBubbleRight:NSLayoutConstraint!
    private let kBubbleCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
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
        
        let views:[String:AnyObject] = [
            "labelContent":labelContent]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[labelContent]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[labelContent]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBubbleTop = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:0)
        layoutBubbleBottom = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:0)
        layoutBubbleLeft = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        layoutBubbleRight = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBubbleTop)
        addConstraint(layoutBubbleBottom)
        addConstraint(layoutBubbleRight)
        addConstraint(layoutBubbleLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MChatItem, controller:CChat)
    {
        let modelText:MChatItemText = model as! MChatItemText
        layoutBubbleTop.constant = modelText.marginTop
        layoutBubbleBottom.constant = modelText.marginBottom
        layoutBubbleLeft.constant = modelText.marginLeft
        layoutBubbleRight.constant = modelText.marginRight
    }
}