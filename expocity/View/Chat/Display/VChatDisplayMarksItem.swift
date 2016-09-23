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
        setImage(UIImage(named:"chatAnnotationSelected"), forState:UIControlState.Focused)
        imageView!.contentMode = UIViewContentMode.Center
        imageView!.clipsToBounds = true
        addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        if !selected
        {
            selected = true
            print("signos")
        }
    }
}