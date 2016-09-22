import UIKit

class VChatInput:UIView, UITextViewDelegate
{
    weak var controller:CChat!
    weak var menu:VChatInputMenu!
    weak var field:UITextView!
    weak var layoutHeight:NSLayoutConstraint!
    weak var layoutBaseRight:NSLayoutConstraint!
    let kMinHeight:CGFloat = 40
    private let kFieldMarginVr:CGFloat = 4
    private let kBorderHeight:CGFloat = 1
    private let kMaxHeight:CGFloat = 75
    private let kCornerRadius:CGFloat = 4
    private let kAnimationDuration:NSTimeInterval = 0.3
    private let kHypoteticalMaxHeight:CGFloat = 10000
    private let kEmpty:String = ""
    
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
        borderTop.userInteractionEnabled = false
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.backgroundColor = UIColor.bubbleMine()
        
        let fieldBase:UIView = UIView()
        fieldBase.clipsToBounds = true
        fieldBase.backgroundColor = UIColor.whiteColor()
        fieldBase.translatesAutoresizingMaskIntoConstraints = false
        fieldBase.layer.borderWidth = 1
        fieldBase.layer.borderColor = UIColor.bubbleMine().CGColor
        fieldBase.layer.cornerRadius = kCornerRadius
        
        let field:UITextView = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clearColor()
        field.font = UIFont.medium(15)
        field.textColor = UIColor.blackColor()
        field.tintColor = UIColor.blackColor()
        field.returnKeyType = UIReturnKeyType.Default
        field.keyboardAppearance = UIKeyboardAppearance.Light
        field.autocorrectionType = UITextAutocorrectionType.No
        field.spellCheckingType = UITextSpellCheckingType.No
        field.autocapitalizationType = UITextAutocapitalizationType.Sentences
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
            "fieldMarginVr":kFieldMarginVr,
            "borderHeight":kBorderHeight,
            "minHeight":kMinHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[fieldBase]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[borderTop(borderHeight)]-(fieldMarginVr)-[fieldBase]-(fieldMarginVr)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-6-[field]-3-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[borderTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[menu]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[menu(minHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        let rightMargin:CGFloat = -menu.rightMargin()
        
        layoutBaseRight = NSLayoutConstraint(
            item:fieldBase,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:rightMargin)
        
        addConstraint(layoutBaseRight)
    }
    
    //MARK: private
    
    private func sendMessage()
    {
        let text:String = field.text
        
        if !text.isEmpty
        {
            var textValidating:String = text.stringByReplacingOccurrencesOfString(" ", withString:"")
            textValidating = textValidating.stringByReplacingOccurrencesOfString("\n", withString:"")
            
            if !textValidating.isEmpty
            {
                controller.addTextMine(text)
            }
            
            dispatch_async(dispatch_get_main_queue())
            { [weak self] in
                
                self?.field.text = self?.kEmpty
                self?.heightForText()
            }
        }
    }
    
    private func heightForText()
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
    
    private func updateRightMargin()
    {
        let rightMargin:CGFloat = -menu.rightMargin()
        layoutBaseRight.constant = rightMargin
        
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    private func updateTypingMenu()
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
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
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
    
    func textViewDidBeginEditing(textView:UITextView)
    {
        heightForText()
        updateTypingMenu()
    }
    
    func textViewDidEndEditing(textView:UITextView)
    {
        heightForText()
        updateStandbyMenu()
    }
    
    func textViewDidChange(textView:UITextView)
    {
        heightForText()
        updateTypingMenu()
    }
}