import UIKit

class VHomeCellAccess:VHomeCell
{
    weak var labelInvitationOnly:UILabel!
    weak var labelFreeJoin:UILabel!
    weak var buttonInvitationOnly:UIButton!
    weak var buttonFreeJoin:UIButton!
    weak var model:MHomeItemAccess!
    private let kTitleHeight:CGFloat = 20
    private let kLabelsWidth:CGFloat = 100
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:14)
        labelTitle.textColor = UIColor.complement()
        labelTitle.text = NSLocalizedString("VHomeCellAccess_labelTitle", comment:"")
        
        let labelInvitationOnly:UILabel = UILabel()
        labelInvitationOnly.isUserInteractionEnabled = false
        labelInvitationOnly.translatesAutoresizingMaskIntoConstraints = false
        labelInvitationOnly.backgroundColor = UIColor.clear
        labelInvitationOnly.textAlignment = NSTextAlignment.right
        labelInvitationOnly.font = UIFont.regular(size:13)
        labelInvitationOnly.textColor = UIColor.main()
        labelInvitationOnly.text = NSLocalizedString("VHomeCellAccess_labelInvitationOnly", comment:"")
        self.labelInvitationOnly = labelInvitationOnly
        
        let labelFreeJoin:UILabel = UILabel()
        labelFreeJoin.isUserInteractionEnabled = false
        labelFreeJoin.translatesAutoresizingMaskIntoConstraints = false
        labelFreeJoin.backgroundColor = UIColor.clear
        labelFreeJoin.textAlignment = NSTextAlignment.left
        labelFreeJoin.font = UIFont.regular(size:13)
        labelFreeJoin.textColor = UIColor.main()
        labelFreeJoin.text = NSLocalizedString("VHomeCellAccess_labelFreeJoin", comment:"")
        self.labelFreeJoin = labelFreeJoin
        
        addSubview(labelTitle)
        addSubview(labelInvitationOnly)
        addSubview(labelFreeJoin)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelInvitationOnly":labelInvitationOnly,
            "labelFreeJoin":labelFreeJoin]
        
        let metrics:[String:CGFloat] = [
            "titleHeight":kTitleHeight,
            "labelsWidth":kLabelsWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[label(titleHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelInvitationOnly(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[labelFreeJoin(labelsWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
