import UIKit

class VHomeCellAccess:VHomeCell
{
    weak var labelInvitationOnly:UILabel!
    weak var labelFreeJoin:UILabel!
    weak var buttonInvitationOnly:UIButton!
    weak var buttonFreeJoin:UIButton!
    weak var model:MHomeItemAccess!
    weak var layoutButtonsLeft:NSLayoutConstraint!
    private let kLabelsHeight:CGFloat = 20
    private let kLabelsWidth:CGFloat = 105
    private let kLabelsMargin:CGFloat = 5
    private let kButtonsWidth:CGFloat = 50
    private let kButtonsHeight:CGFloat = 34
    private let kCornerRadius:CGFloat = 5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textColor = UIColor.complement()
        labelTitle.text = NSLocalizedString("VHomeCellAccess_labelTitle", comment:"")
        
        let labelInvitationOnly:UILabel = UILabel()
        labelInvitationOnly.isUserInteractionEnabled = false
        labelInvitationOnly.translatesAutoresizingMaskIntoConstraints = false
        labelInvitationOnly.backgroundColor = UIColor.clear
        labelInvitationOnly.textAlignment = NSTextAlignment.right
        labelInvitationOnly.font = UIFont.regular(size:12)
        labelInvitationOnly.textColor = UIColor.main()
        labelInvitationOnly.text = NSLocalizedString("VHomeCellAccess_labelInvitationOnly", comment:"")
        self.labelInvitationOnly = labelInvitationOnly
        
        let labelFreeJoin:UILabel = UILabel()
        labelFreeJoin.isUserInteractionEnabled = false
        labelFreeJoin.translatesAutoresizingMaskIntoConstraints = false
        labelFreeJoin.backgroundColor = UIColor.clear
        labelFreeJoin.textAlignment = NSTextAlignment.left
        labelFreeJoin.font = UIFont.regular(size:12)
        labelFreeJoin.textColor = UIColor.main()
        labelFreeJoin.text = NSLocalizedString("VHomeCellAccess_labelFreeJoin", comment:"")
        self.labelFreeJoin = labelFreeJoin
        
        let buttonInvitationOnly:UIButton = UIButton()
        buttonInvitationOnly.translatesAutoresizingMaskIntoConstraints = false
        buttonInvitationOnly.clipsToBounds = true
        buttonInvitationOnly.setImage(#imageLiteral(resourceName: "roomAccessInvitationOnly"), for:UIControlState.normal)
        buttonInvitationOnly.imageView!.contentMode = UIViewContentMode.center
        buttonInvitationOnly.imageView!.clipsToBounds = true
        buttonInvitationOnly.layer.cornerRadius = kCornerRadius
        self.buttonInvitationOnly = buttonInvitationOnly
        
        let buttonFreeJoin:UIButton = UIButton()
        buttonFreeJoin.translatesAutoresizingMaskIntoConstraints = false
        buttonFreeJoin.clipsToBounds = true
        buttonFreeJoin.setImage(#imageLiteral(resourceName: "roomAccessFreeJoin"), for:UIControlState.normal)
        buttonFreeJoin.imageView!.contentMode = UIViewContentMode.center
        buttonFreeJoin.imageView!.clipsToBounds = true
        buttonFreeJoin.layer.cornerRadius = kCornerRadius
        self.buttonFreeJoin = buttonFreeJoin
        
        addSubview(labelTitle)
        addSubview(labelInvitationOnly)
        addSubview(labelFreeJoin)
        addSubview(buttonInvitationOnly)
        addSubview(buttonFreeJoin)
        
        let views:[String:UIView] = [
            "labelTitle":labelTitle,
            "labelInvitationOnly":labelInvitationOnly,
            "labelFreeJoin":labelFreeJoin,
            "buttonInvitationOnly":buttonInvitationOnly,
            "buttonFreeJoin":buttonFreeJoin]
        
        let metrics:[String:CGFloat] = [
            "labelsHeight":kLabelsHeight,
            "labelsWidth":kLabelsWidth,
            "labelsMargin":kLabelsMargin,
            "buttonsWidth":kButtonsWidth,
            "buttonsHeight":kButtonsHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[labelTitle]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "H:[labelInvitationOnly(labelsWidth)]-(labelsMargin)-[buttonInvitationOnly(buttonsWidth)]-0-[buttonFreeJoin(buttonsWidth)]-(labelsMargin)-[labelFreeJoin(labelsWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[labelTitle(labelsHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-60-[labelInvitationOnly(labelsHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-60-[labelFreeJoin(labelsHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-53-[buttonInvitationOnly(buttonsHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-53-[buttonFreeJoin(buttonsHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonsLeft = NSLayoutConstraint(
            item:labelInvitationOnly,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addSubview(layoutButtonsLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
