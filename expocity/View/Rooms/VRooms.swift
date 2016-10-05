import UIKit

class VRooms:UIView
{
    weak var controller:CRooms!
    weak var spinner:VMainLoader?
    
    convenience init(controller:CRooms)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        clipsToBounds = true
        self.controller = controller
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        addSubview(spinner)
    }
    
    //MARK: public
    
    func roomsReload()
    {
        spinner?.removeFromSuperview()
    }
}
