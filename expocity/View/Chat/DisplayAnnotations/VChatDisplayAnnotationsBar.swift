import UIKit

class VChatDisplayAnnotationsBar:UIView
{
    weak var controller:CChatDisplayAnnotations!
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:UIView = UIView()
        border.userInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:1, alpha:0.2)
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named:"genericClose"), forState:UIControlState.Normal)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.Center
        backButton.addTarget(self, action:#selector(self.actionBack(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.bold(18)
        label.textAlignment = NSTextAlignment.Center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.whiteColor()
        label.text = NSLocalizedString("VChatDisplayAnnotationsBar_labelTitle", comment:"")
        
        addSubview(border)
        addSubview(label)
        addSubview(backButton)
        
        let views:[String:AnyObject] = [
            "border":border,
            "backButton":backButton,
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[backButton(44)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[label(44)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.parent.dismiss()
    }
}