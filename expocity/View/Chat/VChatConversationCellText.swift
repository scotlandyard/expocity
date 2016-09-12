import UIKit

class VChatConversationCellText:VChatConversationCell
{
    weak var labelContent:UILabel!
    weak var bubbleContent:UIView!
    weak var layoutBubbleTop:NSLayoutConstraint!
    weak var layoutBubbleHeight:NSLayoutConstraint!
    weak var layoutBubbleLeft:NSLayoutConstraint!
    weak var layoutBubbleWidth:NSLayoutConstraint!
    weak var modelText:MChatItemText!
    private let kBubbleCornerRadius:CGFloat = 4
    private let kInterMarginHr:CGFloat = 8
    private let kInterMarginVr:CGFloat = 5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelContent:UILabel = UILabel()
        labelContent.backgroundColor = UIColor.clearColor()
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.userInteractionEnabled = false
        labelContent.numberOfLines = 0
        labelContent.textColor = UIColor.blackColor()
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
        
        let metrics:[String:AnyObject] = [
            "interMarginHr":kInterMarginHr,
            "interMarginVr":kInterMarginVr]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(interMarginHr)-[labelContent]-(interMarginHr)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(interMarginVr)-[labelContent]-(interMarginVr)-|",
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
        layoutBubbleHeight = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
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
        layoutBubbleWidth = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.Width,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBubbleTop)
        addConstraint(layoutBubbleHeight)
        addConstraint(layoutBubbleLeft)
        addConstraint(layoutBubbleWidth)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MChatItem, controller:CChat)
    {
        super.config(model, controller:controller)
        modelText = model as! MChatItemText
        labelContent.attributedText = modelText.attributedString
        layoutConstraints()
    }
    
    override func layoutConstraints()
    {
        let constantTop:CGFloat = modelText.marginTop - kInterMarginVr
        let constantHeight:CGFloat = modelText.contentHeight
        let constantLeft:CGFloat = (modelText.marginLeft - kInterMarginHr) + modelText.extraMargin
        let constantWidth:CGFloat = modelText.contentWidth
        
        layoutBubbleTop.constant = constantTop
        layoutBubbleHeight.constant = constantHeight
        layoutBubbleLeft.constant = constantLeft
        layoutBubbleWidth.constant = constantWidth
    }
}