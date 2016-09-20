import UIKit

class VChatDisplayAnnotationsTutorial:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var label:UILabel!
    private let kButtonHeight:CGFloat = 40
    
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
        label.font = UIFont.regular(16)
        self.label = label
        
        let cancelButton:UIButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(NSLocalizedString("", comment:""), forState:UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        cancelButton.setTitleColor(UIColor(white:1, alpha:0.2), forState:UIControlState.Highlighted)
        cancelButton.titleLabel!.font = UIFont.bold(16)
        cancelButton.addTarget(self, action:#selector(self.actionCancel(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(label)
        addSubview(cancelButton)
        
        let views:[String:AnyObject] = [
            "label":label]
        
        let metrics:[String:AnyObject] = [
            "buttonHeight":kButtonHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[cancelButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[cancelButton]-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        closeTutorial()
    }
    
    //MARK: public
    
    func closeTutorial()
    {
        alpha = 0
    }
    
    func tutorialPlaceMark()
    {
        alpha = 1
        label.text = NSLocalizedString("VChatDisplayAnnotationsTutorial_tutorialPlaceMark", comment:"")
    }
}