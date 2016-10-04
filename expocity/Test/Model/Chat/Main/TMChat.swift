import XCTest
@testable import expocity

class TMChat:XCTestCase
{
    private let kRoomSnapshot:[String:Any] = [
        "presentation":1,
        "owner":"John Test",
        "name":"My fancy room",
        "created":1475541121.581116,
        "access":1
    ]
    
    //MARK: -
    
    func testFirebaseRoom()
    {
        /*let firebaseRoom:FDatabaseModelRoom = FDatabaseModelRoom(snapshot:[:])
        let userId:String = firebaseRoom.owner
        
        XCTAssertFalse(userId.isEmpty, "Room has no owner")*/
    }
}
