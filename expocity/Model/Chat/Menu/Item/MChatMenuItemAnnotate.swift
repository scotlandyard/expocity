import UIKit

class MChatMenuItemAnnotate:MChatMenuItem
{
    private let kIcon:String = "chatAnnotate"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.displayAnnotations()
    }
}
