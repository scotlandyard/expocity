import UIKit

class VChatDisplayAnnotationsPlacerItem:UIView
{
    weak var model:MChatDisplayAnnotationsItem!
    weak var controller:CChatDisplayAnnotations!
    
    convenience init(model:MChatDisplayAnnotationsItem, controller:CChatDisplayAnnotations)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.model = model
        self.controller = controller
    }
}