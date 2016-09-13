import Foundation

class MChatMenuStatusStandby:MChatMenuStatus
{
    override func items() -> [MChatMenuItem]
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemAnnotate:MChatMenuItemAnnotate = MChatMenuItemAnnotate()
        
        let items:[MChatMenuItem] = [
            itemPicture,
            itemAnnotate
        ]
        
        return items
    }
}