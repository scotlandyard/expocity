import UIKit

class MChatMenuItemPicture:MChatMenuItem
{
    private let kIcon:String = "chatPicture"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        
        if controller.viewChat.display.imageView.image == nil
        {
            controller.viewChat.presentImagePicker()
        }
        else
        {
            showAlert(controller)
        }
    }
    
    //MARK: private
    
    private func showAlert(controller:CChat)
    {
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("MChatMenuItemPicture_alertTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let actionChange:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("MChatMenuItemPicture_alertChange", comment:""),
            style:UIAlertActionStyle.Default)
        { [weak self] (action) in
            
        }
        
        let actionRemove:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("MChatMenuItemPicture_alertRemove", comment:""),
            style:UIAlertActionStyle.Destructive)
        { [weak self] (action) in
            
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("MChatMenuItemPicture_alertCancel", comment:""),
            style:UIAlertActionStyle.Cancel,
            handler:nil)
        
        alert.addAction(actionChange)
        alert.addAction(actionRemove)
        alert.addAction(actionCancel)
        
        controller.parent.presentViewController(
            alert,
            animated:true,
            completion:nil)
    }
}