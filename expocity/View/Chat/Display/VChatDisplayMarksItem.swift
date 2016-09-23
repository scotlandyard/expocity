import UIKit

class VChatDisplayMarksItem:UIButton
{
    weak var controller:CChat!
    weak var timer:NSTimer?
    private let kTimeInterval:NSTimeInterval = 5
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(named:"chatAnnotation"), forState:UIControlState.Normal)
        setImage(UIImage(named:"chatAnnotationSelected"), forState:UIControlState.Selected)
        imageView!.contentMode = UIViewContentMode.Center
        imageView!.clipsToBounds = true
        addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.controller = controller
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        if !selected
        {
            selected = true
            showMessage()
        }
    }
    
    //MARK: private
    
    private func showMessage()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(
            kTimeInterval,
            target:self,
            selector:#selector(self.timeOut(sender:)),
            userInfo:nil,
            repeats:false)
    }
    
    func timeOut(sender timer:NSTimer)
    {
        timer.invalidate()
        selected = false
    }
}