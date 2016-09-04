import UIKit

class CParent:UIViewController
{
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.Default
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let game:CGame = CGame()
        addChildViewController(game)
        view.addSubview(game.view)
        game.didMoveToParentViewController(self)
        
        let views:[String:AnyObject] = [
            "child":game.view]
        
        let metrics:[String:AnyObject] = [:]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[child]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[child]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    //MARK: public
    
    func statusBarLight()
    {
        statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func statusBarDefault()
    {
        statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
}