import UIKit

class VChatEmojiKeyboardFooter:UICollectionReusableView
{
    weak var controller:CChat!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "chatHideKeyboard"), for:UIControlState.normal)
        button.addTarget(
            self,
            action:#selector(self.actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.viewChat.hideEmojiKeyboard()
    }
}
