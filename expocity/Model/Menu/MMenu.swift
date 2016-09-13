import Foundation

class MMenu
{
    let items:[MMenuItem]
    var state:MMenuState
    weak var current:MMenuItem!
    
    init()
    {
        state = MMenuStateOptions()
        
        var items:[MMenuItem] = []
        
        let itemSettings:MMenuItemSettings = MMenuItemSettings(index:items.count)
        items.append(itemSettings)
        
        let itemHistory:MMenuItemHistory = MMenuItemHistory(index:items.count)
        items.append(itemHistory)
        
        let itemHome:MMenuItemHome = MMenuItemHome(index:items.count)
        current = itemHome
        items.append(itemHome)
        
        let itemRooms:MMenuItemRooms = MMenuItemRooms(index:items.count)
        items.append(itemRooms)
        
        self.items = items
    }
}