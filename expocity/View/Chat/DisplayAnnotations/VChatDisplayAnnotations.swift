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
    weak var layoutEditTextBottom:NSLayoutConstraint!
    private let kEditTextHeight:CGFloat = 45
    private let kAnimationDuration:NSTimeInterval = 0.3
    private let kDelayLayout:UInt64 = 100
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let shadeTop:VChatDisplayAnnotationsShade = VChatDisplayAnnotationsShade(borderTop:false, borderBottom:true)
        self.shadeTop = shadeTop
        
        let shadeBottom:VChatDisplayAnnotationsShade = VChatDisplayAnnotationsShade(borderTop:true, borderBottom:false)
        self.shadeBottom = shadeBottom
        
        let list:VChatDisplayAnnotationsList = VChatDisplayAnnotationsList(controller:controller)
        self.list = list
        
        let tutorial:VChatDisplayAnnotationsTutorial = VChatDisplayAnnotationsTutorial(controller:controller)
        self.tutorial = tutorial
        
        let placer:VChatDisplayAnnotationsPlacer = VChatDisplayAnnotationsPlacer(controller:controller)
        self.placer = placer
        
        let editText:VChatDisplayAnnoationsEdit = VChatDisplayAnnoationsEdit(controller:controller)
        self.editText = editText
        
        shadeTop.addSubview(list)
        shadeTop.addSubview(tutorial)
        addSubview(shadeTop)
        addSubview(shadeBottom)
        addSubview(placer)
        addSubview(editText)
        
        let views:[String:AnyObject] = [
            "shadeTop":shadeTop,
            "shadeBottom":shadeBottom,
            "list":list,
            "tutorial":tutorial,
            "placer":placer,
            "editText":editText]
        
        let metrics:[String:AnyObject] = [
            "editTextHeight":kEditTextHeight]
        
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
            "H:|-0-[editText]-0-|",
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
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[editText(editTextHeight)]",
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
        layoutEditTextBottom = NSLayoutConstraint(
            item:editText,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutShadeTopHeight)
        addConstraint(layoutShadeBottomHeight)
        addConstraint(layoutPlacerTop)
        addConstraint(layoutPlacerHeight)
        addConstraint(layoutEditTextBottom)
        
        layoutShades()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector:#selector(self.notifiedKeyboardChanged(sender:)),
            name:UIKeyboardWillChangeFrameNotification,
            object:nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    //MARK: notified
    
    func notifiedKeyboardChanged(sender notification:NSNotification)
    {
        let keyRect:CGRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let yOrigin = keyRect.origin.y
        let screenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height
        let keyboardHeight:CGFloat
        
        if yOrigin < screenHeight
        {
            keyboardHeight = screenHeight - yOrigin
        }
        else
        {
            keyboardHeight = 0
        }
        
        layoutEditTextBottom.constant = -keyboardHeight
        
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
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
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.shadeTop.alpha = 1
            self?.shadeBottom.alpha = 1
        }
    }
    
    func addAnnotation()
    {
        list.alpha = 0
        tutorial.tutorialPlaceMark()
        placer.addAnnotation()
    }
    
    func cancelAnnotation()
    {
        list.alpha = 1
        tutorial.closeTutorial()
        placer.cancelAnnotation()
    }
    
    func confirmAnnotation()
    {
        tutorial.tutorialText()
        editText.beginEditingText()
        placer.reloadItems()
    }
    
    func confirmTextAnnotation()
    {
        list.alpha = 1
        list.collectionView.reloadData()
        tutorial.closeTutorial()
        placer.reloadItems()
    }
}