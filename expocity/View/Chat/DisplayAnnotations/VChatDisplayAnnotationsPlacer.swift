import UIKit

class VChatDisplayAnnotationsPlacer:UIView
{
    weak var controller:CChatDisplayAnnotations!
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        userInteractionEnabled = false
        self.controller = controller
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.actionTap(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    //MARK: actions
    
    func actionTap(sender gesture:UITapGestureRecognizer)
    {
        print("gesture: \(gesture.locationInView(self))")
    }
    
    //MARK: public
    
    func addAnnotation()
    {
        userInteractionEnabled = true
    }
}