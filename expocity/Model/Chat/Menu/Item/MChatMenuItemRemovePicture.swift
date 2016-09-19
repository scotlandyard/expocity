import UIKit

class MChatMenuItemRemovePicture:MChatMenuItem
{
    private let kIcon:String = "chatPicture"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        controller.viewChat.presentImagePicker()
    }
}