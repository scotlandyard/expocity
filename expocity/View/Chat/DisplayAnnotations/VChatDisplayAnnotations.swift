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
    fileprivate let kEditTextHeight:CGFloat = 45
    fileprivate let kAnimationDuration:TimeInterval = 0.3
    fileprivate let kDelayLayout:UInt64 = 100
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
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
            "editTextHeight":kEditTextHeight as AnyObject]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[placer]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[shadeTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[list]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[tutorial]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[editText]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[shadeTop]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[list]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[tutorial]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[editText(editTextHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutShadeTopHeight = NSLayoutConstraint(
            item:shadeTop,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        layoutShadeBottomHeight = NSLayoutConstraint(
            item:shadeBottom,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        layoutPlacerTop = NSLayoutConstraint(
            item:placer,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        layoutPlacerHeight = NSLayoutConstraint(
            item:placer,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        layoutEditTextBottom = NSLayoutConstraint(
            item:editText,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutShadeTopHeight)
        addConstraint(layoutShadeBottomHeight)
        addConstraint(layoutPlacerTop)
        addConstraint(layoutPlacerHeight)
        addConstraint(layoutEditTextBottom)
        
        layoutShades()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedKeyboardChanged(sender:)),
            name:NSNotification.Name.UIKeyboardWillChangeFrame,
            object:nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews()
    {
        let delayLayout:UInt64 = self.kDelayLayout
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.shadeTop.alpha = 0
            self?.shadeBottom.alpha = 0
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(NSEC_PER_MSEC * delayLayout)) / Double(NSEC_PER_SEC))
            { [weak self] in
                
                self?.layoutShades()
                self?.animateShades()
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: notified
    
    func notifiedKeyboardChanged(sender notification:Notification)
    {
        let keyRect:CGRect = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let yOrigin = keyRect.origin.y
        let screenHeight:CGFloat = UIScreen.main.bounds.size.height
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
        
        UIView.animate(withDuration: kAnimationDuration, animations: { [weak self] in
            
            self?.layoutIfNeeded()
        })
        
    }
    
    //MARK: private
    
    fileprivate func layoutShades()
    {
        let imageRect:CGRect = controller.controllerChat.displayImageRect()
        let screenRect:CGRect = UIScreen.main.bounds
        let topHeight:CGFloat = imageRect.minY
        let bottomHeight:CGFloat = screenRect.maxY - imageRect.maxY
        
        layoutShadeTopHeight.constant = topHeight
        layoutShadeBottomHeight.constant = bottomHeight
        layoutPlacerTop.constant = topHeight
        layoutPlacerHeight.constant = imageRect.size.height
    }
    
    fileprivate func modelAtIndex(_ index:IndexPath) -> MChatDisplayAnnotationsItem
    {
        let item:MChatDisplayAnnotationsItem = controller.controllerChat.model.annotations.items[(index as NSIndexPath).item]
        
        return item
    }
    
    //MARK: public
    
    func animateShades()
    {
        UIView.animate(withDuration: kAnimationDuration, animations: { [weak self] in
            
            self?.shadeTop.alpha = 1
            self?.shadeBottom.alpha = 1
        })
        
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
