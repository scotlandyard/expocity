import UIKit

class MChatMenuItemAnnotate:MChatMenuItem
{
    fileprivate let kIcon:String = "chatAnnotate"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(_ controller:CChat)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.displayAnnotations()
    }
}
