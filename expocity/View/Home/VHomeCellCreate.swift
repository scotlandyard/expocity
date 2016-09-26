import UIKit

class VHomeCellCreate:VHomeCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        
        let base:UIView = UIView()
        base.isUserInteractionEnabled = false
        base.translatesAutoresizingMaskIntoConstraints = false
        base.backgroundColor = UIColor.complement()
        base.layer.cornerRadius = 4
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.bold(16)
        label.textColor = UIColor.white
        label.text = NSLocalizedString("VHomeCellCreate_label", comment:"")
        
        addSubview(base)
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "label":label,
            "base":base]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[base]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[base]-5-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func selected(_ controller:CHome)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        let model:MChat = controller.model.chat()
        let chat:CChat = CChat(model:model)
        controller.parentController.push(chat)
    }
}
