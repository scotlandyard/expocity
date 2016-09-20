import UIKit

class VChatDisplayAnnotationsPlacer:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var tapGesture:UITapGestureRecognizer!
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.actionTap(sender:)))
        self.tapGesture = tapGesture
        addGestureRecognizer(tapGesture)
        
        reloadItems()
    }
    
    //MARK: actions
    
    func actionTap(sender tapGesture:UITapGestureRecognizer)
    {
        print("gesture: \(tapGesture.locationInView(self))")
    }
    
    //MARK: public
    
    func addAnnotation()
    {
        tapGesture.enabled = true
    }
    
    func cancelAnnotation()
    {
        tapGesture.enabled = false
    }
    
    func reloadItems()
    {
        tapGesture.enabled = false
        
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