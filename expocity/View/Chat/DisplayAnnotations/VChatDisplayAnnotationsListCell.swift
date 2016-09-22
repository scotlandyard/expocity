import UIKit

class VChatDisplayAnnotationsListCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var controller:CChatDisplayAnnotations!
    weak var model:MChatDisplayAnnotationsItem!
    private let kButtonRemoveWidth:CGFloat = 55
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.1)
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(14)
        label.textColor = UIColor(white:1, alpha:0.85)
        label.backgroundColor = UIColor.clearColor()
        self.label = label
        
        let buttonRemove:UIButton = UIButton()
        buttonRemove.setImage(UIImage(named:"chatAnnotationRemove"), forState:UIControlState.Normal)
        buttonRemove.imageView!.contentMode = UIViewContentMode.Center
        buttonRemove.imageView!.clipsToBounds = true
        buttonRemove.translatesAutoresizingMaskIntoConstraints = false
        buttonRemove.addTarget(
            self,
            action:#selector(self.actionRemove(sender:)),
            forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(label)
        addSubview(buttonRemove)
        
        let views:[String:AnyObject] = [
            "label":label,
            "buttonRemove":buttonRemove]
        
        let metrics:[String:AnyObject] = [
            "buttonRemoveWidth":kButtonRemoveWidth]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[label]-0-[buttonRemove(buttonRemoveWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[buttonRemove]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionRemove(sender button:UIButton)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        let text:String = model.text
        
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeTitle", comment:""),
            message:text,
            preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let actionDo:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeButton", comment:""),
            style:
            UIAlertActionStyle.Default)
        { [weak self] (action) in
            
            
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeCancel", comment:""),
            style:UIAlertActionStyle.Cancel,
            handler:nil)
        
        alert.addAction(actionDo)
        alert.addAction(actionCancel)
        
        controller.parent.presentViewController(
            alert,
            animated:true,
            completion:nil)
    }
    
    //MARK: public
    
    func config(model:MChatDisplayAnnotationsItem, controller:CChatDisplayAnnotations)
    {
        self.model = model
        self.controller = controller
        label.text = model.text
    }
}