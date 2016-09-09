import UIKit

class VChatInput:UIView, UITextFieldDelegate
{
    weak var controller:CChat!
    weak var field:UITextField!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
        self.controller = controller
        
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clearColor()
        field.borderStyle = UITextBorderStyle.None
        field.font = UIFont.bold(16)
        field.textColor = UIColor.blackColor()
        field.tintColor = UIColor.blackColor()
        field.returnKeyType = UIReturnKeyType.Done
        field.keyboardAppearance = UIKeyboardAppearance.Light
        field.autocorrectionType = UITextAutocorrectionType.No
        field.spellCheckingType = UITextSpellCheckingType.No
        field.autocapitalizationType = UITextAutocapitalizationType.Words
        field.clearButtonMode = UITextFieldViewMode.Never
        field.placeholder = NSLocalizedString("VHomeCellTitle_placeholder", comment:"")
        field.delegate = self
        self.field = field
        
        addSubview(field)
        
        let views:[String:AnyObject] = [
            "field":field]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[field]-30-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: text delegate
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        
        return true
    }
}