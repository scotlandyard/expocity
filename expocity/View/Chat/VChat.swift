import UIKit

class VChat:UIView
{
    weak var controller:CChat!
    weak var input:VChatInput!
    weak var layoutInputBottom:NSLayoutConstraint!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let input:VChatInput = VChatInput(controller:controller)
        self.input = input
        
        addSubview(input)
        
        layoutInputBottom = NSLayoutConstraint(
            item:input,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:0)
    }
}