import UIKit

class VChatInput:UIView
{
    weak var controller:CChat!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
        self.controller = controller
    }
}