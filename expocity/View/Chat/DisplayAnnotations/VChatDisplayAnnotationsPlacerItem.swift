import UIKit

class VChatDisplayAnnotationsPlacerItem:UIButton
{
    weak var model:MChatDisplayAnnotationsItem!
    weak var controller:CChatDisplayAnnotations!
    
    convenience init(model:MChatDisplayAnnotationsItem, controller:CChatDisplayAnnotations)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        setImage(#imageLiteral(resourceName: "chatAnnotation"), for:UIControlState())
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(self.actionSelect(sender:)),
            for:UIControlEvents.touchUpInside)
        self.model = model
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionSelect(sender button:UIButton)
    {
        
    }
}
