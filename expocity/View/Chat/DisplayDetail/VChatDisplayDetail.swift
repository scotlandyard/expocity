import UIKit

class VChatDisplayDetail:UIView
{
    weak var controller:CChatDisplayDetail!
    
    convenience init(controller:CChatDisplayDetail)
    {
        self.init()
        self.controller = controller
    }
}