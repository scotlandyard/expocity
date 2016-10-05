import UIKit

class VRoomsFooter:UICollectionReusableView
{
    weak var controller:CRooms!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
