import Vapor
import Foundation

public protocol NodesModel: Model {
    var created_at: Date? { set get }
    var updated_at: Date? { set get }
    var deleted_at: Date? { set get }
}

extension NodesModel {
    //FIXME(Brett): not going to get called until Vapor fixes it
    public mutating func willCreate() {
        created_at = Date()
        updated_at = Date()
    }
    
    //FIXME(Brett): not going to get called until Vapor fixes it
    public mutating func willUpdate() {
        updated_at = Date()
    }
    
    public mutating func save() throws {
        let now = Date()
        
        if created_at == nil {
            created_at = now
        }
        
        updated_at = now
        
        try Self.query().save(&self)
    }
    
    public mutating func delete() throws {
        deleted_at = Date()
        try save()
    }
}
