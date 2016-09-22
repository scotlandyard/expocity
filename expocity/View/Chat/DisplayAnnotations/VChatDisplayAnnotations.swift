import UIKit

class VChatDisplayAnnotations:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var shadeTop:VChatDisplayAnnotationsShade!
    weak var shadeBottom:VChatDisplayAnnotationsShade!
    weak var list:VChatDisplayAnnotationsList!
    weak var tutorial:VChatDisplayAnnotationsTutorial!
    weak var placer:VChatDisplayAnnotationsPlacer!
    weak var editText:VChatDisplayAnnoationsEdit!
    weak var layoutShadeTopHeight:NSLayoutConstraint!
    weak var layoutShadeBottomHeight:NSLayoutConstraint!
    weak var layoutPlacerTop:NSLayoutConstraint!
    weak var layoutPlacerHeight:NSLayoutConstraint!
    private let kAnimateDuration:NSTimeInterval = 0.3
    private let kDelayLayout:UInt64 = 100
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let shadeTop:VChatDisplayAnnotationsShade = VChatDisplayAnnotationsShade()
        self.shadeTop = shadeTop
        
        let shadeBottom:VChatDisplayAnnotationsShade = VChatDisplayAnnotationsShade()
        self.shadeBottom = shadeBottom
        
        let list:VChatDisplayAnnotationsList = VChatDisplayAnnotationsList(controller:controller)
        self.list = list
        
        let tutorial:VChatDisplayAnnotationsTutorial = VChatDisplayAnnotationsTutorial(controller:controller)
        self.tutorial = tutorial
        
        let placer:VChatDisplayAnnotationsPlacer = VChatDisplayAnnotationsPlacer(controller:controller)
        self.placer = placer
        
        let editText:VChatDisplayAnnoationsEdit = VChatDisplayAnnoationsEdit(model: <#T##MChatDisplayAnnotationsItem#>, controller: <#T##CChatDisplayAnnotations#>)
        
        shadeTop.addSubview(list)
        shadeTop.addSubview(tutorial)
        addSubview(shadeTop)
        addSubview(shadeBottom)
        addSubview(placer)
        
        let views:[String:AnyObject] = [
            "shadeTop":shadeTop,
            "shadeBottom":shadeBottom,
            "list":list,
            "tutorial":tutorial,
            "placer":placer]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[placer]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadeTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[list]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[tutorial]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[shadeTop]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[list]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[tutorial]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutShadeTopHeight = NSLayoutConstraint(
            item:shadeTop,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        layoutShadeBottomHeight = NSLayoutConstraint(
            item:shadeBottom,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        layoutPlacerTop = NSLayoutConstraint(
            item:placer,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:0)
        layoutPlacerHeight = NSLayoutConstraint(
            item:placer,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutShadeTopHeight)
        addConstraint(layoutShadeBottomHeight)
        addConstraint(layoutPlacerTop)
        addConstraint(layoutPlacerHeight)
        
        layoutShades()
    }
    
    override func layoutSubviews()
    {
        let delayLayout:UInt64 = self.kDelayLayout
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.shadeTop.alpha = 0
            self?.shadeBottom.alpha = 0
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC * delayLayout)), dispatch_get_main_queue())
            { [weak self] in
                
                self?.layoutShades()
                self?.animateShades()
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func layoutShades()
    {
        let imageRect:CGRect = controller.controllerChat.displayImageRect()
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let topHeight:CGFloat = imageRect.minY
        let bottomHeight:CGFloat = screenRect.maxY - imageRect.maxY
        
        layoutShadeTopHeight.constant = topHeight
        layoutShadeBottomHeight.constant = bottomHeight
        layoutPlacerTop.constant = topHeight
        layoutPlacerHeight.constant = imageRect.size.height
    }
    
    private func modelAtIndex(index:NSIndexPath) -> MChatDisplayAnnotationsItem
    {
        let item:MChatDisplayAnnotationsItem = controller.controllerChat.model.annotations.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func animateShades()
    {
        UIView.animateWithDuration(kAnimateDuration)
        { [weak self] in
            
            self?.shadeTop.alpha = 1
            self?.shadeBottom.alpha = 1
        }
    }
    
    func addAnnotation()
    {
        list.userInteractionEnabled = false
        tutorial.tutorialPlaceMark()
        placer.addAnnotation()
    }
    
    func cancelAnnotation()
    {
        list.userInteractionEnabled = true
        tutorial.closeTutorial()
        placer.cancelAnnotation()
    }
    
    func confirmAnnotation()
    {
        list.userInteractionEnabled = true
        list.collectionView.reloadData()
        tutorial.closeTutorial()
        placer.reloadItems()
    }
}