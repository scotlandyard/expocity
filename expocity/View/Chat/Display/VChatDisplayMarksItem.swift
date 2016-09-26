import UIKit

class VChatDisplayMarksItem:UIButton
{
    weak var controller:CChat!
    weak var timer:Timer?
    weak var model:MChatDisplayAnnotationsItem!
    fileprivate let kTimeInterval:TimeInterval = 3
    
    convenience init(controller:CChat, model:MChatDisplayAnnotationsItem)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(named:"chatAnnotation"), for:UIControlState())
        setImage(UIImage(named:"chatAnnotationSelected"), for:UIControlState.selected)
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(self, action:#selector(self.actionButton(sender:)), for:UIControlEvents.touchUpInside)
        self.model = model
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        if !isSelected
        {
            isSelected = true
            showMessage()
        }
    }
    
    //MARK: private
    
    fileprivate func showMessage()
    {
        timer = Timer.scheduledTimer(
            timeInterval: kTimeInterval,
            target:self,
            selector:#selector(self.timeOut(sender:)),
            userInfo:nil,
            repeats:false)
        
        let alertMessage:String = model.text
        let alertType:VMainAlert.VMainAlertType = VMainAlert.VMainAlertType.annotation
        VMainAlert.Show(alertMessage, type:alertType)
    }
    
    func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        isSelected = false
    }
}
