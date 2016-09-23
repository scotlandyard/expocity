import UIKit

class VChatDisplayAnnotationsTutorial:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var label:UILabel!
    private let kButtonHeight:CGFloat = 50
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        userInteractionEnabled = false
        alpha = 0
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.regular(20)
        self.label = label
        
        let cancelButton:UIButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(NSLocalizedString("VChatDisplayAnnotationsTutorial_cancelButton", comment:""), forState:UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        cancelButton.setTitleColor(UIColor(white:1, alpha:0.2), forState:UIControlState.Highlighted)
        cancelButton.titleLabel!.font = UIFont.bold(20)
        cancelButton.addTarget(self, action:#selector(self.actionCancel(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(label)
        addSubview(cancelButton)
        
        let views:[String:AnyObject] = [
            "label":label,
            "cancelButton":cancelButton]
        
        let metrics:[String:AnyObject] = [
            "buttonHeight":kButtonHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[cancelButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[label]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[cancelButton(buttonHeight)]-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        
        userInteractionEnabled = false
        controller.cancelAnnotation()
    }
    
    //MARK: public
    
    func closeTutorial()
    {
        alpha = 0
    }
    
    func tutorialPlaceMark()
    {
        alpha = 1
        userInteractionEnabled = true
        label.text = NSLocalizedString("VChatDisplayAnnotationsTutorial_tutorialPlaceMark", comment:"")
    }
    
    func tutorialText()
    {
        label.text = NSLocalizedString("VChatDisplayAnnotationsTutorial_tutorialText", comment:"")
    }
}