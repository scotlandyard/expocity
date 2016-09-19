import UIKit

class MChatDisplayOptionsItem
{
    let title:String
    let icon:String
    let contentMode:UIViewContentMode
    
    init(title:String, icon:String, contentMode:UIViewContentMode)
    {
        self.title = title
        self.icon = icon
        self.contentMode = contentMode
    }
}