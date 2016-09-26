import UIKit

class VHomeCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    fileprivate func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = 0.2
        }
        else
        {
            alpha = 1
        }
    }
    
    //MARK: public
    
    func config(_ model:MHomeItem)
    {
        hover()
    }
    
    func selected(_ controller:CHome)
    {
    }
}
