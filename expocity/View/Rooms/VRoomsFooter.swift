import UIKit

class VRoomsFooter:UICollectionReusableView
{
    weak var controller:CRooms!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonCreate:UIButton = UIButton()
        buttonCreate.translatesAutoresizingMaskIntoConstraints = false
        buttonCreate.backgroundColor = UIColor.complement()
        buttonCreate.clipsToBounds = true
        buttonCreate.setTitle(NSLocalizedString("VRoomsFooter_buttonCreate", comment:""), for:UIControlState.normal)
        buttonCreate.titleLabel!.font = UIFont.bold(size:14)
        buttonCreate.setTitleColor(UIColor.white, for:UIControlState.normal)
        
        addSubview(buttonCreate)
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
