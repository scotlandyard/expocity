import UIKit

class VHomeCellCreate:VHomeCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        
        let base:UIView = UIView()
        base.userInteractionEnabled = false
        base.translatesAutoresizingMaskIntoConstraints = false
        base.backgroundColor = UIColor.complement()
        base.layer.cornerRadius = 4
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.bold(16)
        label.textColor = UIColor.whiteColor()
        label.text = NSLocalizedString("VHomeCellCreate_label", comment:"")
        
        addSubview(base)
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "label":label,
            "base":base]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[base]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-5-[base]-5-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        
        let model:MChat = controller.model.chat()
        let chat:CChat = CChat(model:model)
        controller.parent.push(chat)
    }
}