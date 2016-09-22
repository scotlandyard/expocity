import UIKit

class VChatDisplayAnnotations:UIView
{
    weak var controller:CChat!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}