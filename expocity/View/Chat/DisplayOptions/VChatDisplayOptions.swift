import UIKit

class VChatDisplayOptions:UIView
{
    weak var controller:CChatDisplayOptions!
    
    convenience init(controller:CChatDisplayOptions)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        self.controller = controller
    }
}