import UIKit

class VMainAlert:UIView
{
    enum VMainAlertType
    {
        case Annotation
        case Warning
        case Error
    }
    
    private let kHeight:CGFloat = 80
    
    class func Show(message:String)
    {
        dispatch_async(dispatch_get_main_queue())
        {
            let alert:VMainAlert = VMainAlert(message:message)
            
            UIApplication.sharedApplication().keyWindow!.rootViewController!.view.addSubview(alert)
        }
    }
    
    convenience init(message:String)
    {
        self.init()
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.regular(16)
        label.textColor = UIColor.whiteColor()
        label.text = message
        
        addSubview(label)
    }
}