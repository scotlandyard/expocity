import UIKit

class VChatDisplayAnnoationsEdit:UIView, UITextFieldDelegate
{
    weak var controller:CChatDisplayAnnotations!
    weak var textField:UITextField!
    private let kBorderRadius:CGFloat = 4
    private let kDoneButtonWidth:CGFloat = 65
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        backgroundColor = UIColor(white:0.96, alpha:1)
        self.controller = controller
        
        let borderColor:UIColor = UIColor(white:0, alpha:0.1)
        
        let topBorder:UIView = UIView()
        topBorder.isUserInteractionEnabled = false
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.backgroundColor = borderColor
        
        let doneButton:UIButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle(NSLocalizedString("VChatDisplayAnnoationsEdit_doneButton", comment:""), for:UIControlState())
        doneButton.setTitleColor(UIColor.main(), for:UIControlState())
        doneButton.setTitleColor(UIColor.main().withAlphaComponent(0.2), for:UIControlState.highlighted)
        doneButton.titleLabel!.font = UIFont.bold(size:15)
        doneButton.addTarget(
            self,
            action:#selector(self.actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let fieldBase:UIView = UIView()
        fieldBase.translatesAutoresizingMaskIntoConstraints = false
        fieldBase.clipsToBounds = true
        fieldBase.backgroundColor = UIColor.white
        fieldBase.layer.cornerRadius = kBorderRadius
        fieldBase.layer.borderWidth = 1
        fieldBase.layer.borderColor = borderColor.cgColor
        
        let textField:UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextBorderStyle.none
        textField.font = UIFont.regular(size:16)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardAppearance = UIKeyboardAppearance.light
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.sentences
        textField.clearButtonMode = UITextFieldViewMode.never
        textField.placeholder = NSLocalizedString("VChatDisplayAnnoationsEdit_placerholder", comment:"")
        textField.delegate = self
        self.textField = textField
        
        fieldBase.addSubview(textField)
        addSubview(topBorder)
        addSubview(fieldBase)
        addSubview(doneButton)
        
        let views:[String:UIView] = [
            "textField":textField,
            "fieldBase":fieldBase,
            "doneButton":doneButton,
            "topBorder":topBorder]
        
        let metrics:[String:CGFloat] = [
            "doneButtonWidth":kDoneButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-6-[fieldBase]-0-[doneButton(doneButtonWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-7-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[topBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[textField]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[doneButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-6-[fieldBase]-6-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[topBorder(1)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        textField.resignFirstResponder()
    }
    
    //MARK: private
    
    private func confirmText()
    {
        isHidden = true
        let text:String = textField.text!
        textField.text = ""
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.confirmTextAnnotation(text:text)
    }
    
    //MARK: public
    
    func beginEditingText()
    {
        isHidden = false
        textField.becomeFirstResponder()
    }
    
    //MARK: field delegate
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        confirmText()
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
