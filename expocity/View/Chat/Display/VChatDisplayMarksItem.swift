import UIKit

class VChatDisplayMarksItem:UIButton
{
    weak var controller:CChat!
    weak var timer:Timer?
    weak var model:MChatDisplayAnnotationsItem!
    private let kTimeInterval:TimeInterval = 3
    
    convenience init(controller:CChat, model:MChatDisplayAnnotationsItem)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(#imageLiteral(resourceName: "chatAnnotation"), for:UIControlState())
        setImage(#imageLiteral(resourceName: "chatAnnotationSelected"), for:UIControlState.selected)
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
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
    
    private func showMessage()
    {
        timer = Timer.scheduledTimer(
            timeInterval:kTimeInterval,
            target:self,
            selector:#selector(timeOut(sender:)),
            userInfo:nil,
            repeats:false)
        
        let alertMessage:String = model.text
        let alertType:VMainAlert.AlertType = VMainAlert.AlertType.annotation
        VMainAlert.Show(message:alertMessage, type:alertType)
    }
    
    func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        isSelected = false
    }
}
