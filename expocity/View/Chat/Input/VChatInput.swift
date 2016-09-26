import UIKit

class VChatInput:UIView, UITextViewDelegate
{
    weak var controller:CChat!
    weak var menu:VChatInputMenu!
    weak var field:UITextView!
    weak var layoutHeight:NSLayoutConstraint!
    weak var layoutBaseRight:NSLayoutConstraint!
    let kMinHeight:CGFloat = 40
    fileprivate let kFieldMarginVr:CGFloat = 4
    fileprivate let kBorderHeight:CGFloat = 1
    fileprivate let kMaxHeight:CGFloat = 75
    fileprivate let kCornerRadius:CGFloat = 4
    fileprivate let kAnimationDuration:TimeInterval = 0.3
    fileprivate let kHypoteticalMaxHeight:CGFloat = 10000
    fileprivate let kEmpty:String = ""
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        self.controller = controller
        
        let menu:VChatInputMenu = VChatInputMenu(controller:controller)
        self.menu = menu
        
        let borderTop:UIView = UIView()
        borderTop.isUserInteractionEnabled = false
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.backgroundColor = UIColor.bubbleMine()
        
        let fieldBase:UIView = UIView()
        fieldBase.clipsToBounds = true
        fieldBase.backgroundColor = UIColor.white
        fieldBase.translatesAutoresizingMaskIntoConstraints = false
        fieldBase.layer.borderWidth = 1
        fieldBase.layer.borderColor = UIColor.bubbleMine().cgColor
        fieldBase.layer.cornerRadius = kCornerRadius
        
        let field:UITextView = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clear
        field.font = UIFont.medium(15)
        field.textColor = UIColor.black
        field.tintColor = UIColor.black
        field.returnKeyType = UIReturnKeyType.default
        field.keyboardAppearance = UIKeyboardAppearance.light
        field.autocorrectionType = UITextAutocorrectionType.no
        field.spellCheckingType = UITextSpellCheckingType.no
        field.autocapitalizationType = UITextAutocapitalizationType.sentences
        field.textContainerInset = UIEdgeInsetsMake(6, 0, 0, 0)
        field.delegate = self
        self.field = field
        
        fieldBase.addSubview(field)
        addSubview(borderTop)
        addSubview(menu)
        addSubview(fieldBase)
        
        let views:[String:AnyObject] = [
            "field":field,
            "fieldBase":fieldBase,
            "borderTop":borderTop,
            "menu":menu]
        
        let metrics:[String:AnyObject] = [
            "fieldMarginVr":kFieldMarginVr as AnyObject,
            "borderHeight":kBorderHeight as AnyObject,
            "minHeight":kMinHeight as AnyObject]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[fieldBase]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[borderTop(borderHeight)]-(fieldMarginVr)-[fieldBase]-(fieldMarginVr)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-6-[field]-3-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[borderTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[menu]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[menu(minHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        let rightMargin:CGFloat = -menu.rightMargin()
        
        layoutBaseRight = NSLayoutConstraint(
            item:fieldBase,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:rightMargin)
        
        addConstraint(layoutBaseRight)
    }
    
    //MARK: private
    
    fileprivate func sendMessage()
    {
        let text:String = field.text
        
        if !text.isEmpty
        {
            var textValidating:String = text.replacingOccurrences(of: " ", with:"")
            textValidating = textValidating.replacingOccurrences(of: "\n", with:"")
            
            if !textValidating.isEmpty
            {
                controller.addTextMine(text)
            }
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.field.text = self?.kEmpty
                self?.heightForText()
            }
        }
    }
    
    fileprivate func heightForText()
    {
        let newHeight:CGFloat
        let height:CGFloat = field.contentSize.height + kFieldMarginVr + kBorderHeight
        
        if height > kMaxHeight
        {
            newHeight = kMaxHeight
        }
        else if height < kMinHeight
        {
            newHeight = kMinHeight
        }
        else
        {
            newHeight = height
        }
        
        layoutHeight.constant = newHeight
    }
    
    fileprivate func updateRightMargin()
    {
        let rightMargin:CGFloat = -menu.rightMargin()
        layoutBaseRight.constant = rightMargin
        
        UIView.animate(withDuration: kAnimationDuration, animations: { [weak self] in
            
            self?.layoutIfNeeded()
        })
        
    }
    
    fileprivate func updateTypingMenu()
    {
        if field.text.isEmpty
        {
            menu.modeTypeReady()
        }
        else
        {
            menu.modeTyping()
        }
        
        updateRightMargin()
    }
    
    //MARK: public
    
    func actionSend()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.sendMessage()
        }
    }
    
    func updateStandbyMenu()
    {
        if controller.viewChat.display.imageView.image == nil
        {
            menu.modeStandby()
        }
        else
        {
            menu.modeStandbyImage()
        }
        
        updateRightMargin()
    }
    
    //MARK: textview del
    
    func textViewDidBeginEditing(_ textView:UITextView)
    {
        heightForText()
        updateTypingMenu()
    }
    
    func textViewDidEndEditing(_ textView:UITextView)
    {
        heightForText()
        updateStandbyMenu()
    }
    
    func textViewDidChange(_ textView:UITextView)
    {
        heightForText()
        updateTypingMenu()
    }
}
