import Foundation

class MMenuStatePushed:MMenuState
{
    override func showBackButton() -> Bool
    {
        return true
    }
    
    override func showTitle() -> Bool
    {
        return true
    }
}