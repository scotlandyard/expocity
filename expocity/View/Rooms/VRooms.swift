import UIKit

class VRooms:UIView
{
    weak var controller:CRooms!
    
    convenience init(controller:CRooms)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        clipsToBounds = true
        self.controller = controller
    }
}
