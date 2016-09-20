import UIKit

class VChatDisplayAnnoationsEdit:UIView, UITextFieldDelegate
{
    weak var model:MChatDisplayAnnotationsItem!
    weak var controller:CChatDisplayAnnotations!
    weak var textField:UITextField!
    private let kBorderRadius:CGFloat = 4
    
    convenience init(model:MChatDisplayAnnotationsItem, controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.model = model
        self.controller = controller

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
        
        let views:[String:AnyObject] = [
            "textField":textField,
            "fieldBase":fieldBase]
        
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
    
    //MARK: field delegate
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}