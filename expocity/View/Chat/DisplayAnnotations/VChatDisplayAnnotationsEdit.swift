import UIKit

class VChatDisplayAnnoationsEdit:UIView, UITextFieldDelegate
{
    weak var controller:CChatDisplayAnnotations!
    weak var textField:UITextField!
    private let kBorderRadius:CGFloat = 4
    private let kDoneButtonWidth:CGFloat = 60
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        hidden = true
        backgroundColor = UIColor(white:0.9, alpha:1)
        self.controller = controller
        
        let doneButton:UIButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle(NSLocalizedString("VChatDisplayAnnoationsEdit_doneButton", comment:""), forState:UIControlState.Normal)
        doneButton.setTitleColor(UIColor.main(), forState:UIControlState.Normal)
        doneButton.setTitleColor(UIColor.main().colorWithAlphaComponent(0.2), forState:UIControlState.Highlighted)
        doneButton.titleLabel!.font = UIFont.bold(14)
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
        addSubview(fieldBase)
        addSubview(doneButton)
        
        let views:[String:AnyObject] = [
            "textField":textField,
            "fieldBase":fieldBase,
            "doneButton":doneButton]
        
        let metrics:[String:AnyObject] = [
            "doneButtonWidth":kDoneButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-6-[fieldBase]-0-[doneButton(doneButtonWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-5-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[doneButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-6-[fieldBase]-6-|",
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
        controller.confirmAnnotation(<#T##xPercent: CGFloat##CGFloat#>, yPercent: <#T##CGFloat#>)
    }
    
    //MARK: public
    
    func beginEditingText()
    {
        hidden = false
        textField.becomeFirstResponder()
    }
    
    //MARK: field delegate
    
    func textFieldDidEndEditing(textField:UITextField)
    {
        let text:String = textField.text!
        controller.addingAnnotation?.text = text
        hidden = true
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}