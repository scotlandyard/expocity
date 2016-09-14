import UIKit

class VChatDisplayDetailBar:UIView
{
    weak var controller:CChatDisplayDetail!
    
    convenience init(controller:CChatDisplayDetail)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let closeButton:UIButton = UIButton()
        closeButton.clipsToBounds = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action:#selector(self.actionClose(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(closeButton)
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.parent.pop()
    }
}