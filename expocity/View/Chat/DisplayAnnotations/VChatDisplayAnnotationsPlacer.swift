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
    
    func cancelAnnotation()
    {
        userInteractionEnabled = false
    }
    
    func reloadItems()
    {
        var count:Int = subviews.count - 1
        while count >= 0
        {
            let subview:UIView = subviews[count]
            subview.removeFromSuperview()
            count -= 1
        }
        
        for item:MChatDisplayAnnotationsItem in controller.controllerChat.model.annotations.items
        {
            let subview:VChatDisplayAnnotationsPlacerItem = VChatDisplayAnnotationsPlacerItem(model:item, controller:controller)
            addSubview(subview)
        }
    }
}