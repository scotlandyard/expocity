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
        isUserInteractionEnabled = false
        alpha = 0
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.font = UIFont.regular(size:20)
        self.label = label
        
        let cancelButton:UIButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(NSLocalizedString("VChatDisplayAnnotationsTutorial_cancelButton", comment:""), for:UIControlState())
        cancelButton.setTitleColor(UIColor.white, for:UIControlState())
        cancelButton.setTitleColor(UIColor(white:1, alpha:0.2), for:UIControlState.highlighted)
        cancelButton.titleLabel!.font = UIFont.bold(size:20)
        cancelButton.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(label)
        addSubview(cancelButton)
        
        let views:[String:UIView] = [
            "label":label,
            "cancelButton":cancelButton]
        
        let metrics:[String:CGFloat] = [
            "buttonHeight":kButtonHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[cancelButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[label]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[cancelButton(buttonHeight)]-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        isUserInteractionEnabled = false
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
        isUserInteractionEnabled = true
        label.text = NSLocalizedString("VChatDisplayAnnotationsTutorial_tutorialPlaceMark", comment:"")
    }
    
    func tutorialText()
    {
        label.text = NSLocalizedString("VChatDisplayAnnotationsTutorial_tutorialText", comment:"")
    }
}
