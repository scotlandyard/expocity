import UIKit

class VRoom:UIView
{
    weak var controller:CRoom!
    
    convenience init(controller:CRoom)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
        clipsToBounds = true
        self.controller = controller
    }
}