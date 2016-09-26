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
        UIApplication.shared.keyWindow!.endEditing(true)
        
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
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionChange:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("MChatMenuItemPicture_alertChange", comment:""),
            style:UIAlertActionStyle.default)
        { [weak controller] (action) in
            
            controller?.viewChat.presentImagePicker()
        }
        
        let actionRemove:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("MChatMenuItemPicture_alertRemove", comment:""),
            style:UIAlertActionStyle.destructive)
        { [weak controller] (action) in
            
            controller?.removeImage()
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("MChatMenuItemPicture_alertCancel", comment:""),
            style:UIAlertActionStyle.cancel,
            handler:nil)
        
        alert.addAction(actionChange)
        alert.addAction(actionRemove)
        alert.addAction(actionCancel)
        
        controller.parentController.present(
            alert,
            animated:true,
            completion:nil)
    }
}
