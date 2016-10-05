import UIKit

class VRoomsFooter:UICollectionReusableView
{
    weak var controller:CRooms!
    weak var layoutButtonCreateLeft:NSLayoutConstraint!
    private let kButtonCreateWidth:CGFloat = 170
    private let kButtonCreateHeight:CGFloat = 37
    private let kButtonCreateTop:CGFloat = 30
    private let kCornerRadius:CGFloat = 4
    
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
        buttonCreate.setTitleColor(UIColor(white:1, alpha:0.2), for:UIControlState.highlighted)
        buttonCreate.layer.cornerRadius = kCornerRadius
        buttonCreate.addTarget(
            self,
            action:#selector(actionCreate(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCreate)
        
        let views:[String:UIView] = [
            "buttonCreate":buttonCreate]
        
        let metrics:[String:CGFloat] = [
            "buttonCreateWidth":kButtonCreateWidth,
            "buttonCreateHeight":kButtonCreateHeight,
            "buttonCreateTop":kButtonCreateTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCreate(buttonCreateWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(buttonCreateTop)-[buttonCreate(buttonCreateHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonCreateLeft = NSLayoutConstraint(
            item:buttonCreate,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        
        addConstraint(layoutButtonCreateLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonCreateWidth
        let margin:CGFloat = remain / 2.0
        layoutButtonCreateLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCreate(sender button:UIButton)
    {
        controller.createRoom()
    }
}
