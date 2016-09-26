import UIKit

class VHomeCellTitle:VHomeCell, UITextFieldDelegate
{
    weak var field:UITextField!
    weak var modelTitle:MHomeItemTitle!
    private let kCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        
        let base:UIView = UIView()
        base.isUserInteractionEnabled = false
        base.translatesAutoresizingMaskIntoConstraints = false
        base.backgroundColor = UIColor.collectionBackground()
        base.clipsToBounds = true
        base.layer.cornerRadius = kCornerRadius
        
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clear
        field.borderStyle = UITextBorderStyle.none
        field.font = UIFont.bold(16)
        field.textColor = UIColor.black
        field.tintColor = UIColor.black
        field.returnKeyType = UIReturnKeyType.done
        field.keyboardAppearance = UIKeyboardAppearance.light
        field.autocorrectionType = UITextAutocorrectionType.no
        field.spellCheckingType = UITextSpellCheckingType.no
        field.autocapitalizationType = UITextAutocapitalizationType.words
        field.clearButtonMode = UITextFieldViewMode.never
        field.placeholder = NSLocalizedString("VHomeCellTitle_placeholder", comment:"")
        field.delegate = self
        self.field = field
        
        addSubview(base)
        addSubview(field)
        
        let views:[String:UIView] = [
            "field":field,
            "base":base]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-16-[field]-12-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[base]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-14-[base]-14-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MHomeItem)
    {
        modelTitle = model as! MHomeItemTitle
        field.text = modelTitle.title
    }
    
    //MARK: field del
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        modelTitle.title = textField.text!
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
