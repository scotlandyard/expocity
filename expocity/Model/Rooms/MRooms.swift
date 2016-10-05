import Foundation

class MRooms
{
    let items:[MRoomsItem]
    
    init(rooms:FDatabaseModelUserRooms)
    {
        var items:[MRoomsItem] = []
        
        for roomId:String in rooms.rooms
        {
            let roomItem:MRoomsItem = MRoomsItem(roomId:roomId)
            items.append(roomItem)
        }
        
        self.items = items
    }
}
