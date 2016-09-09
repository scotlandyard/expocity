import UIKit

class VChatInput:UIView, UITextFieldDelegate
{
    weak var controller:CChat!
    weak var field:UITextField!
    private let kCornerRadius:CGFloat = 4
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        self.controller = controller
        
        let fieldBase:UIView = UIView()
        fieldBase.clipsToBounds = true
        fieldBase.backgroundColor = UIColor.whiteColor()
        fieldBase.translatesAutoresizingMaskIntoConstraints = false
        fieldBase.layer.borderWidth = 1
        fieldBase.layer.borderColor = UIColor(white:0, alpha:0.1).CGColor
        fieldBase.layer.cornerRadius = kCornerRadius
        
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clearColor()
        field.borderStyle = UITextBorderStyle.None
        field.font = UIFont.bold(14)
        field.textColor = UIColor.blackColor()
        field.tintColor = UIColor.blackColor()
        field.returnKeyType = UIReturnKeyType.Done
        field.keyboardAppearance = UIKeyboardAppearance.Light
        field.autocorrectionType = UITextAutocorrectionType.No
        field.spellCheckingType = UITextSpellCheckingType.No
        field.autocapitalizationType = UITextAutocapitalizationType.Sentences
        field.clearButtonMode = UITextFieldViewMode.Never
        field.delegate = self
        self.field = field
        
        fieldBase.addSubview(field)
        addSubview(fieldBase)
        
        let views:[String:AnyObject] = [
            "field":field,
            "fieldBase":fieldBase]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-40-[fieldBase]-90-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-4-[fieldBase]-4-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[field]-5-|",
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
        textField.resignFirstResponder()
        
        return true
    }
}