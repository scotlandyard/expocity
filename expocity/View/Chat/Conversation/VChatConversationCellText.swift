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
    fileprivate let interMarginVr2:CGFloat
    fileprivate let interMarginHr2:CGFloat
    fileprivate let kBubbleCornerRadius:CGFloat = 4
    fileprivate let kInterMarginHr:CGFloat = 8
    fileprivate let kInterMarginVr:CGFloat = 5
    
    override init(frame:CGRect)
    {
        interMarginHr2 = kInterMarginHr + kInterMarginHr
        interMarginVr2 = kInterMarginVr + kInterMarginVr
        
        super.init(frame:frame)
        
        let labelContent:UILabel = UILabel()
        labelContent.backgroundColor = UIColor.clear
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.isUserInteractionEnabled = false
        labelContent.numberOfLines = 0
        labelContent.textColor = UIColor.black
        self.labelContent = labelContent
        
        let bubbleContent:UIView = UIView()
        bubbleContent.clipsToBounds = true
        bubbleContent.translatesAutoresizingMaskIntoConstraints = false
        bubbleContent.isUserInteractionEnabled = false
        bubbleContent.layer.cornerRadius = kBubbleCornerRadius
        self.bubbleContent = bubbleContent
        
        bubbleContent.addSubview(labelContent)
        addSubview(bubbleContent)
        
        let views:[String:AnyObject] = [
            "labelContent":labelContent]
        
        let metrics:[String:AnyObject] = [
            "interMarginHr":kInterMarginHr as AnyObject,
            "interMarginVr":kInterMarginVr as AnyObject]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(interMarginHr)-[labelContent]-(interMarginHr)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(interMarginVr)-[labelContent]-(interMarginVr)-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBubbleTop = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        layoutBubbleHeight = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        layoutBubbleLeft = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        layoutBubbleWidth = NSLayoutConstraint(
            item:bubbleContent,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
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
    
    override func config(_ model:MChatItem, controller:CChat)
    {
        super.config(model, controller:controller)
        modelText = model as! MChatItemText
        labelContent.attributedText = modelText.attributedString
        layoutConstraints()
    }
    
    override func layoutConstraints()
    {
        let constantTop:CGFloat = modelText.marginTop - kInterMarginVr
        let constantHeight:CGFloat = modelText.contentHeight + interMarginVr2
        let constantLeft:CGFloat = (modelText.marginLeft - kInterMarginHr) + modelText.extraMargin
        let constantWidth:CGFloat = modelText.contentWidth + interMarginHr2
        
        layoutBubbleTop.constant = constantTop
        layoutBubbleHeight.constant = constantHeight
        layoutBubbleLeft.constant = constantLeft
        layoutBubbleWidth.constant = constantWidth
    }
}
