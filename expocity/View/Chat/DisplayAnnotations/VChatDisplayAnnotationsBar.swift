import UIKit

class VChatDisplayAnnotationsBar:UIView
{
    weak var controller:CChatDisplayAnnotations!
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:1, alpha:0.2)
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named:"genericClose"), for:UIControlState())
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
        backButton.addTarget(self, action:#selector(self.actionBack(sender:)), for:UIControlEvents.touchUpInside)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(16)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = NSLocalizedString("VChatDisplayAnnotationsBar_labelTitle", comment:"")
        
        let addButton:UIButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named:"genericAdd"), for:UIControlState())
        addButton.imageView!.clipsToBounds = true
        addButton.imageView!.contentMode = UIViewContentMode.center
        addButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0)
        addButton.addTarget(self, action:#selector(self.actionAdd(sender:)), for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(label)
        addSubview(backButton)
        addSubview(addButton)
        
        let views:[String:AnyObject] = [
            "border":border,
            "backButton":backButton,
            "label":label,
            "addButton":addButton]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[addButton(60)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[backButton(44)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[label(44)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[addButton(44)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.controllerChat.viewChat.listenToKeyboard()
        controller.controllerChat.viewChat.display.hideAnnotations()
        controller.parentController.dismiss()
    }
    
    func actionAdd(sender button:UIButton)
    {
        controller.addAnnotation()
    }
}
