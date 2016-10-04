import UIKit

class VChat:UIView
{
    weak var controller:CChat!
    weak var input:VChatInput!
    weak var display:VChatDisplay!
    weak var conversation:VChatConversation!
    weak var emojiKeyboard:VChatEmojiKeyboard!
    weak var layoutInputBottom:NSLayoutConstraint!
    weak var spinner:VMainLoader?
    private let kAnimationDuration:TimeInterval = 0.4
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        addSubview(spinner)
        
        let views:[String:UIView] = [
            "spinner":spinner]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedKeyboardChanged(sender notification:Notification)
    {
        let userInfo:[AnyHashable:Any] = notification.userInfo!
        let keyboardFrameValue:NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyRect:CGRect = keyboardFrameValue.cgRectValue
        let yOrigin = keyRect.origin.y
        let screenHeight:CGFloat = UIScreen.main.bounds.size.height
        let keyboardHeight:CGFloat
        
        if yOrigin < screenHeight
        {
            keyboardHeight = screenHeight - yOrigin
        }
        else
        {
            keyboardHeight = 0
        }
        
        let newInputBottom:CGFloat = -keyboardHeight
        animateInput(bottom:newInputBottom)
    }
    
    //MARK: private
    
    private func chatLoaded()
    {
        spinner?.removeFromSuperview()
        
        let input:VChatInput = VChatInput(controller:controller)
        self.input = input
        
        let conversation:VChatConversation = VChatConversation(controller:controller)
        self.conversation = conversation
        
        let display:VChatDisplay = VChatDisplay(controller:controller)
        self.display = display
        
        let emojiKeyboard:VChatEmojiKeyboard = VChatEmojiKeyboard(controller:controller)
        self.emojiKeyboard = emojiKeyboard
        
        addSubview(conversation)
        addSubview(display)
        addSubview(input)
        addSubview(emojiKeyboard)
        
        let views:[String:UIView] = [
            "input":input,
            "conversation":conversation,
            "display":display,
            "emojiKeyboard":emojiKeyboard]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[input]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[display]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[conversation]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[emojiKeyboard]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[conversation]-0-[display]-0-[input]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[emojiKeyboard]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutInputBottom = NSLayoutConstraint(
            item:input,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        input.layoutHeight = NSLayoutConstraint(
            item:input,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:input.kMinHeight)
        display.layoutHeight = NSLayoutConstraint(
            item:display,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:display.kMinHeight)
        emojiKeyboard.layoutHeight = NSLayoutConstraint(
            item:emojiKeyboard,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutInputBottom)
        addConstraint(input.layoutHeight)
        addConstraint(display.layoutHeight)
        addConstraint(emojiKeyboard.layoutHeight)
        
        listenToKeyboard()
    }
    
    private func animateInput(bottom:CGFloat)
    {
        let currentOffset:CGPoint = conversation.collectionView.contentOffset
        let newCollectionOffsetY:CGFloat = currentOffset.y - bottom
        layoutInputBottom.constant = bottom
        conversation.collectionView.contentOffset = CGPoint(x:0, y:newCollectionOffsetY)
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: public
    
    func presentImagePicker()
    {
        let chatPicker:CChatDisplayPicker = CChatDisplayPicker(controller:controller)
        
        controller.present(chatPicker, animated:true, completion:nil)
    }
    
    func listenToKeyboard()
    {
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedKeyboardChanged(sender:)),
            name:NSNotification.Name.UIKeyboardWillChangeFrame,
            object:nil)
    }
    
    func displayEmojiKeyboard()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        emojiKeyboard.animateKeyboard(show:true)
        
        let emojiKeyboardHeight:CGFloat = emojiKeyboard.layoutHeight.constant
        let inputHeight:CGFloat = input.layoutHeight.constant
        let inputBottom:CGFloat = -(emojiKeyboardHeight - inputHeight)
        
        animateInput(bottom:inputBottom)
    }
    
    func hideEmojiKeyboard()
    {
        emojiKeyboard.animateKeyboard(show:false)
        animateInput(bottom:0)
    }
}
