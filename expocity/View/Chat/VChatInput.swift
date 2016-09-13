import UIKit

class VChatInput:UIView, UITextViewDelegate
{
    weak var controller:CChat!
    weak var sendButton:UIButton!
    weak var field:UITextView!
    weak var layoutHeight:NSLayoutConstraint!
    let kMinHeight:CGFloat = 40
    private let kMaxExtraLine:Int = 2
    private let kAddedHeight:CGFloat = 18
    private let kCornerRadius:CGFloat = 4
    private let kSendButtonWidth:CGFloat = 50
    private let kEmpty:String = ""
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        self.controller = controller
        
        let borderTop:UIView = UIView()
        borderTop.userInteractionEnabled = false
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.backgroundColor = UIColor.bubbleMine()
        
        let sendButton:UIButton = UIButton()
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setImage(UIImage(named:"chatSend"), forState:UIControlState.Normal)
        sendButton.imageView!.contentMode = UIViewContentMode.Center
        sendButton.imageView!.clipsToBounds = true
        sendButton.addTarget(self, action:#selector(self.actionSend(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.sendButton = sendButton
        
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
        addSubview(fieldBase)
        addSubview(sendButton)
        
        let views:[String:AnyObject] = [
            "field":field,
            "fieldBase":fieldBase,
            "sendButton":sendButton,
            "borderTop":borderTop]
        
        let metrics:[String:AnyObject] = [
            "sendButtonWidth":kSendButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[fieldBase]-0-[sendButton(sendButtonWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[borderTop(1)]-4-[fieldBase]-4-|",
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
            "V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[sendButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
   
    func actionSend(sender button:UIButton)
    {
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        sendMessage()
    }
    
    //MARK: private
    
    private func sendMessage()
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
            
            let text:String? = self?.field.text
            
            if text != nil
            {
                if !text!.isEmpty
                {
                    self?.controller.addTextMine(text!)
                    
                    dispatch_async(dispatch_get_main_queue())
                    { [weak self] in
                        
                        self?.field.text = self?.kEmpty
                        
                        if self != nil
                        {
                            self!.heightForText(self!.kEmpty)
                        }
                    }
                }
            }
        }
    }
    
    private func heightForText(text:String)
    {
        var newHeight:CGFloat = kMinHeight
        let arrLines:[String] = text.componentsSeparatedByString("\n")
        var countLines:Int = arrLines.count - 1
        
        if countLines > 0
        {
            if countLines > kMaxExtraLine
            {
                countLines = kMaxExtraLine
            }
            
            newHeight += CGFloat(countLines) * kAddedHeight
        }
        
        layoutHeight.constant = newHeight
    }
    
    //MARK: textview del
    
    func textView(textView:UITextView, shouldChangeTextInRange range:NSRange, replacementText text:String) -> Bool
    {
        let currentText:NSString = NSString(string:textView.text)
        let newText:String = currentText.stringByReplacingCharactersInRange(range, withString:text)
        heightForText(newText)
        
        return true
    }
}