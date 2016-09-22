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
        modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
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
    
    override func viewDidAppear(animated:Bool)
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
        addingAnnotation?.moveToPoint(xPercent, yPercent:yPercent)
        viewAnnotations.confirmAnnotation()
    }
    
    func confirmTextAnnotation(text:String)
    {
        addingAnnotation?.text = text
        viewAnnotations.confirmTextAnnotation()
    }
    
    func removeAnnotation(item:MChatDisplayAnnotationsItem)
    {
        controllerChat.model.annotations.removeAnnotation(item)
    }
}