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
    }
}