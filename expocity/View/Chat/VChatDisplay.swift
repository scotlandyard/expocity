import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    
    convenience init(controller:CChat)
    {
        self.init()
        self.controller = controller
    }
}
