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
        setImage(UIImage(named:"chatAnnotation"), forState:UIControlState.Normal)
        imageView!.contentMode = UIViewContentMode.Center
        imageView!.clipsToBounds = true
        addTarget(self, action:#selector(self.actionSelect(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.model = model
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionSelect(sender button:UIButton)
    {
        
    }
}