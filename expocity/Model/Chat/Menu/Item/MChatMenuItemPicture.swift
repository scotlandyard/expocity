import UIKit

class MChatMenuItemPicture:MChatMenuItem
{
    private let kIcon:String = "chatSend"
    
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