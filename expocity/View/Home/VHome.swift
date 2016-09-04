import UIKit

class VHome:UIView
{
    weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        userInteractionEnabled = false
        self.controller = controller
    }
}