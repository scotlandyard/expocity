import UIKit

class CChatDisplayAnnotations:CController
{
    weak var viewAnnotations:VChatDisplayAnnotations!
    weak var controllerChat:CChat!
    weak var addingAnnotation:MChatDisplayAnnotationsItem?
    
    init(controllerChat:CChat)
    {
        self.controllerChat = controllerChat
        super.init(nibName:nil, bundle:nil)
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewAnnotations:VChatDisplayAnnotations = VChatDisplayAnnotations(controller:self)
        self.viewAnnotations = viewAnnotations
        view = viewAnnotations
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewAnnotations.animateShades()
    }
    
    //MARK: public
    
    func addAnnotation()
    {
        addingAnnotation = controllerChat.model.annotations.addAnnotation()
        viewAnnotations.addAnnotation()
    }
    
    func cancelAnnotation()
    {
        controllerChat.model.annotations.items.removeLast()
        viewAnnotations.cancelAnnotation()
    }
    
    func confirmAnnotation(xPercent:CGFloat, yPercent:CGFloat)
    {
        addingAnnotation?.moveToPoint(xPercent:xPercent, yPercent:yPercent)
        viewAnnotations.confirmAnnotation()
    }
    
    func confirmTextAnnotation(text:String)
    {
        addingAnnotation?.text = text
        viewAnnotations.confirmTextAnnotation()
        controllerChat.viewChat.display.marks.addItems()
    }
    
    func removeAnnotation(item:MChatDisplayAnnotationsItem)
    {
        controllerChat.model.annotations.removeAnnotation(item:item)
        controllerChat.viewChat.display.marks.addItems()
        viewAnnotations.list.collectionView.reloadData()
        viewAnnotations.placer.reloadItems()
    }
}
