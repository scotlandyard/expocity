import UIKit

class VChat:UIView
{
    weak var controller:CChat!
    weak var input:VChatInput!
    weak var conversation:VChatConversation!
    weak var layoutInputBottom:NSLayoutConstraint!
    private let kInputHeight:CGFloat = 40
    
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
        
        addSubview(input)
        addSubview(conversation)
        
        let views:[String:AnyObject] = [
            "input":input,
            "conversation":conversation]
        
        let metrics:[String:AnyObject] = [
            "inputHeight":kInputHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[input]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[conversation]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[conversation]-0-[input(inputHeight)]",
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
        
        addConstraint(layoutInputBottom)
    }
}