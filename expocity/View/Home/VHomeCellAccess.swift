import UIKit

class VHomeCellAccess:VHomeCell
{
    weak var labelInvitationOnly:UILabel!
    weak var labelFreeJoin:UILabel!
    weak var buttonInvitationOnly:UIButton!
    weak var buttonFreeJoin:UIButton!
    weak var model:MHomeItemAccess!
    weak var layoutButtonsLeft:NSLayoutConstraint!
    private let colorNotSelected:UIColor
    private let buttonsTotalWidth:CGFloat
    private let kLabelsHeight:CGFloat = 20
    private let kLabelsWidth:CGFloat = 100
    private let kLabelsMargin:CGFloat = 8
    private let kButtonsWidth:CGFloat = 42
    private let kButtonsHeight:CGFloat = 34
    private let kCornerRadius:CGFloat = 5
    
    override init(frame:CGRect)
    {
        buttonsTotalWidth = kLabelsWidth + kLabelsMargin + kButtonsWidth + kButtonsWidth + kLabelsMargin + kLabelsWidth
        colorNotSelected = UIColor(white:0.88, alpha:1)
        
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.textColor = UIColor.complement()
        labelTitle.text = NSLocalizedString("VHomeCellAccess_labelTitle", comment:"")
        
        let labelInvitationOnly:UILabel = UILabel()
        labelInvitationOnly.isUserInteractionEnabled = false
        labelInvitationOnly.translatesAutoresizingMaskIntoConstraints = false
        labelInvitationOnly.backgroundColor = UIColor.clear
        labelInvitationOnly.textAlignment = NSTextAlignment.right
        labelInvitationOnly.font = UIFont.regular(size:12)
        labelInvitationOnly.text = NSLocalizedString("VHomeCellAccess_labelInvitationOnly", comment:"")
        self.labelInvitationOnly = labelInvitationOnly
        
        let labelFreeJoin:UILabel = UILabel()
        labelFreeJoin.isUserInteractionEnabled = false
        labelFreeJoin.translatesAutoresizingMaskIntoConstraints = false
        labelFreeJoin.backgroundColor = UIColor.clear
        labelFreeJoin.textAlignment = NSTextAlignment.left
        labelFreeJoin.font = UIFont.regular(size:12)
        labelFreeJoin.text = NSLocalizedString("VHomeCellAccess_labelFreeJoin", comment:"")
        self.labelFreeJoin = labelFreeJoin
        
        let buttonInvitationOnly:UIButton = UIButton()
        buttonInvitationOnly.translatesAutoresizingMaskIntoConstraints = false
        buttonInvitationOnly.clipsToBounds = true
        buttonInvitationOnly.setImage(
            #imageLiteral(resourceName: "roomAccessInvitationOnly").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonInvitationOnly.imageView!.contentMode = UIViewContentMode.center
        buttonInvitationOnly.imageView!.clipsToBounds = true
        buttonInvitationOnly.layer.cornerRadius = kCornerRadius
        buttonInvitationOnly.addTarget(
            self,
            action:#selector(actionInvitationOnly(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonInvitationOnly = buttonInvitationOnly
        
        let buttonFreeJoin:UIButton = UIButton()
        buttonFreeJoin.translatesAutoresizingMaskIntoConstraints = false
        buttonFreeJoin.clipsToBounds = true
        buttonFreeJoin.setImage(
            #imageLiteral(resourceName: "roomAccessFreeJoin").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonFreeJoin.imageView!.contentMode = UIViewContentMode.center
        buttonFreeJoin.imageView!.clipsToBounds = true
        buttonFreeJoin.layer.cornerRadius = kCornerRadius
        buttonFreeJoin.addTarget(
            self,
            action:#selector(actionFreeJoin(sender:)),
            for:UIControlEvents.touchUpInside)
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
            withVisualFormat:"V:|-15-[labelTitle(labelsHeight)]",
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
        
        addConstraint(layoutButtonsLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let maxWidth:CGFloat = bounds.maxX
        let remainWidth:CGFloat = maxWidth - buttonsTotalWidth
        let margin:CGFloat = remainWidth / 2.0
        layoutButtonsLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    override func config(model:MHomeItem)
    {
        self.model = model as! MHomeItemAccess
        hover()
    }
    
    //MARK: actions
    
    func actionInvitationOnly(sender button:UIButton)
    {
        model.access = FDatabaseModelRoom.Access.invitationOnly
        hover()
    }
    
    func actionFreeJoin(sender button:UIButton)
    {
        model.access = FDatabaseModelRoom.Access.freeJoin
        hover()
    }
    
    //MARK: private
    
    private func hover()
    {
        switch model.access
        {
            case FDatabaseModelRoom.Access.invitationOnly:
                
                showInvitationOnly()
                
                break
                
            case FDatabaseModelRoom.Access.freeJoin:
     
                showFreeJoin()
                
                break
        }
    }
    
    private func showInvitationOnly()
    {
        buttonInvitationOnly.backgroundColor = UIColor.main()
        buttonInvitationOnly.imageView!.tintColor = UIColor.white
        labelInvitationOnly.textColor = UIColor.main()
        buttonFreeJoin.backgroundColor = UIColor.clear
        buttonFreeJoin.imageView!.tintColor = colorNotSelected
        labelFreeJoin.textColor = colorNotSelected
    }
    
    private func showFreeJoin()
    {
        buttonInvitationOnly.backgroundColor = UIColor.clear
        buttonInvitationOnly.imageView!.tintColor = colorNotSelected
        labelInvitationOnly.textColor = colorNotSelected
        buttonFreeJoin.backgroundColor = UIColor.main()
        buttonFreeJoin.imageView!.tintColor = UIColor.white
        labelFreeJoin.textColor = UIColor.main()
    }
}
