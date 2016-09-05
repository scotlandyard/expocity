import Foundation

class MMenu
{
    let items:[MMenuItem]
    
    init()
    {
        var items:[MMenuItem] = []
        
        let itemSettings:MMenuItemSettings = MMenuItemSettings(index:items.count)
        items.append(itemSettings)
        
        let itemHistory:MMenuItemHistory = MMenuItemHistory(index:items.count)
        items.append(itemHistory)
        
        let itemHome:MMenuItemHome = MMenuItemHome(index:items.count)
        items.append(itemHome)
        
        self.items = items
    }
}