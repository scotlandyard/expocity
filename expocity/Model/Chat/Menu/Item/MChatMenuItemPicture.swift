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
        controller.viewChat.presentImagePicker()
    }
    
    //MARK: private
    
    private func showAlert()
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        let text:String = model.text
        
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeTitle", comment:""),
            message:text,
            preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let actionDo:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeButton", comment:""),
            style:
            UIAlertActionStyle.Default)
        { [weak self] (action) in
            
            if self != nil
            {
                self!.controller.removeAnnotation(self!.model)
            }
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:NSLocalizedString("VChatDisplayAnnotationsListCell_removeCancel", comment:""),
            style:UIAlertActionStyle.Cancel,
            handler:nil)
        
        alert.addAction(actionDo)
        alert.addAction(actionCancel)
        
        controller.parent.presentViewController(
            alert,
            animated:true,
            completion:nil)
    }
}