import UIKit

class VChat:UIView
{
    weak var controller:CChat!
    weak var input:VChatInput!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}