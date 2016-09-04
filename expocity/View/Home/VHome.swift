import UIKit

class VGame:UIView
{
    weak var controller:CGame!
    weak var racket:VGameRacket!
    
    convenience init(controller:CGame)
    {
        self.init()
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        userInteractionEnabled = false
        self.controller = controller
    }
    
    override func touchesBegan(touches:Set<UITouch>, withEvent event:UIEvent?)
    {
        let touch:UITouch = touches.first!
        let point:CGPoint = touch.locationInView(self)
        racket.touchedAt(point)
    }
    
    override func touchesMoved(touches:Set<UITouch>, withEvent event:UIEvent?)
    {
        let touch:UITouch = touches.first!
        let point:CGPoint = touch.locationInView(self)
        racket.touchedAt(point)
    }
    
    //MARKK: public
    
    func load()
    {
        self.racket = VGameRacket(controller:controller)
        userInteractionEnabled = true
    }
    
    func tick()
    {
        racket.tick()
    }
}