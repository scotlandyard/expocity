import UIKit

class VChatDisplayAnnoationsEdit:UIView, UITextFieldDelegate
{
    weak var model:MChatDisplayAnnotationsItem?
    weak var controller:CChatDisplayAnnotations!
    weak var textField:UITextField!
    private let kBorderRadius:CGFloat = 4
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        hidden = true
        self.controller = controller

        let removeButton:UIButton = UIButton()
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.setImage(UIImage(named:"genericClose"), forState:UIControlState.Normal)
        removeButton.imageView!.clipsToBounds = true
        removeButton.imageView!.contentMode = UIViewContentMode.Center
        removeButton.addTarget(self, action:#selector(self.actionRemove(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        let doneButton:UIButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setImage(UIImage(named:"genericAdd"), forState:UIControlState.Normal)
        doneButton.imageView!.clipsToBounds = true
        doneButton.imageView!.contentMode = UIViewContentMode.Center
        doneButton.addTarget(self, action:#selector(self.actionDone(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        let fieldBase:UIView = UIView()
        fieldBase.translatesAutoresizingMaskIntoConstraints = false
        fieldBase.clipsToBounds = true
        fieldBase.backgroundColor = UIColor.whiteColor()
        fieldBase.layer.cornerRadius = kBorderRadius
        
        let textField:UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.clearColor()
        textField.borderStyle = UITextBorderStyle.None
        textField.font = UIFont.regular(14)
        textField.textColor = UIColor.blackColor()
        textField.tintColor = UIColor.blackColor()
        textField.returnKeyType = UIReturnKeyType.Done
        textField.keyboardAppearance = UIKeyboardAppearance.Light
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.spellCheckingType = UITextSpellCheckingType.No
        textField.autocapitalizationType = UITextAutocapitalizationType.Sentences
        textField.clearButtonMode = UITextFieldViewMode.Never
        textField.placeholder = NSLocalizedString("VChatDisplayAnnoationsEdit_placerholder", comment:"")
        textField.delegate = self
        self.textField = textField
        
        fieldBase.addSubview(textField)
        addSubview(textField)
        addSubview(doneButton)
        addSubview(removeButton)
        
        let views:[String:AnyObject] = [
            "textField":textField,
            "fieldBase":fieldBase,
            "doneButton":doneButton,
            "removeButton":removeButton]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[fieldBase]-0-[removeButton]-0-[doneButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-4-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[removeButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[doneButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-4-[fieldBase]-4-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionRemove(sender button:UIButton)
    {
        /*
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("CNotifications_title", comment:""),
            message:
            item.title,
            preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let actionDo:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("CNotifications_actionDo", comment:""),
            style:
            UIAlertActionStyle.Default)
        { [weak self] (action) in
            
            if self != nil
            {
                item.executeAction(self!)
            }
            
            let titleDone:String = NSLocalizedString("CNotifications_actionDone", comment:"")
            VMainAlert.Message(titleDone)
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("CNotifications_actionCancel", comment:""),
            style:UIAlertActionStyle.Cancel,
            handler:nil)
        
        alert.addAction(actionDo)
        alert.addAction(actionCancel)
        presentViewController(alert, animated:true, completion:nil)*/
    }
    
    func actionDone(sender button:UIButton)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
    }
    
    //MARK: field delegate
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}