import UIKit

class VChat:UIView
{
    weak var controller:CChat!
    weak var input:VChatInput!
    weak var display:VChatDisplay!
    weak var conversation:VChatConversation!
    weak var layoutInputBottom:NSLayoutConstraint!
    private let kAnimationDuration:NSTimeInterval = 0.4
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let input:VChatInput = VChatInput(controller:controller)
        self.input = input
        
        let conversation:VChatConversation = VChatConversation(controller:controller)
        self.conversation = conversation
        
        let display:VChatDisplay = VChatDisplay(controller:controller)
        self.display = display
        
        addSubview(input)
        addSubview(conversation)
        addSubview(display)
        
        let views:[String:AnyObject] = [
            "input":input,
            "conversation":conversation,
            "display":display]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[input]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[display]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[conversation]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[conversation]-0-[display]-0-[input]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutInputBottom = NSLayoutConstraint(
            item:input,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:0)
        
        input.layoutHeight = NSLayoutConstraint(
            item:input,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:input.kMinHeight)
        
        display.layoutHeight = NSLayoutConstraint(
            item:display,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:display.kMinHeight)
        
        addConstraint(layoutInputBottom)
        addConstraint(input.layoutHeight)
        addConstraint(display.layoutHeight)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(self.notifiedKeyboardChanged(sender:)), name:UIKeyboardWillChangeFrameNotification, object:nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedKeyboardChanged(sender notification:NSNotification)
    {
        let keyRect:CGRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let yOrigin = keyRect.origin.y
        let screenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height
        let currentOffset:CGPoint = conversation.collection.contentOffset
        let keyboardHeight:CGFloat
        
        if yOrigin < screenHeight
        {
            keyboardHeight = screenHeight - yOrigin
        }
        else
        {
            keyboardHeight = 0
        }
        
        layoutInputBottom.constant = -keyboardHeight
        conversation.collection.contentOffset = CGPointMake(0, currentOffset.y + keyboardHeight)
        
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}