import UIKit

class VChatDisplayMarksItem:UIButton
{
    weak var controller:CChat!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(named:"chatAnnotation"), forState:UIControlState.Normal)
        setImage(UIImage(named:"chatAnnotationSelected"), forState:UIControlState.Highlighted)
        setImage(UIImage(named:"chatAnnotationSelected"), forState:UIControlState.Selected)
        imageView!.contentMode = UIViewContentMode.Center
        imageView!.clipsToBounds = true
        self.controller = controller
    }
}