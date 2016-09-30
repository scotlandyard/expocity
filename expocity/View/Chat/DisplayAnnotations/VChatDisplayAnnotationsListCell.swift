import UIKit

class VChatDisplayAnnotationsListCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var controller:CChatDisplayAnnotations!
    weak var model:MChatDisplayAnnotationsItem!
    private let kButtonRemoveWidth:CGFloat = 55
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.1)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(size:16)
        label.textColor = UIColor(white:1, alpha:0.9)
        label.backgroundColor = UIColor.clear
        self.label = label
        
        let buttonRemove:UIButton = UIButton()
        buttonRemove.setImage(#imageLiteral(resourceName: "chatAnnotationRemove"), for:UIControlState())
        buttonRemove.imageView!.contentMode = UIViewContentMode.center
        buttonRemove.imageView!.clipsToBounds = true
        buttonRemove.translatesAutoresizingMaskIntoConstraints = false
        buttonRemove.addTarget(
            self,
            action:#selector(self.actionRemove(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(label)
        addSubview(buttonRemove)
        
        let views:[String:UIView] = [
            "label":label,
            "buttonRemove":buttonRemove]
        
        let metrics:[String:CGFloat] = [
            "buttonRemoveWidth":kButtonRemoveWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-0-[buttonRemove(buttonRemoveWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonRemove]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionRemove(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        let text:String = model.text
        
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeTitle", comment:""),
            message:text,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionDo:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeButton", comment:""),
            style:UIAlertActionStyle.default)
        { [weak self] (action) in
            
            if self != nil
            {
                self!.controller.removeAnnotation(item:self!.model)
            }
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeCancel", comment:""),
            style:UIAlertActionStyle.cancel,
            handler:nil)
        
        alert.addAction(actionDo)
        alert.addAction(actionCancel)
        
        controller.parentController.present(
            alert,
            animated:true,
            completion:nil)
    }
    
    //MARK: public
    
    func config(model:MChatDisplayAnnotationsItem, controller:CChatDisplayAnnotations)
    {
        self.model = model
        self.controller = controller
        label.text = model.text
    }
}
