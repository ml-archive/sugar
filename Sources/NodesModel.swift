import Vapor
import Fluent
import Foundation

public protocol NodesModel: Model {
    var createdAt: Date? { set get }
    var updatedAt: Date? { set get }
    var deletedAt: Date? { set get }
    
    static var softDeletable: Bool { get }
}

extension NodesModel {
    public var deletedAt: Date? {
        return nil
    }
    
    public static var softDeletable: Bool {
        return true
    }
}

extension NodesModel {
    //FIXME(Brett): not going to get called until Vapor fixes it
    public mutating func willCreate() {
        createdAt = Date()
        updatedAt = Date()
    }
    
    //FIXME(Brett): not going to get called until Vapor fixes it
    public mutating func willUpdate() {
        updatedAt = Date()
    }
    
    public mutating func save() throws {
        let now = Date()
        
        if createdAt == nil {
            createdAt = now
        }
        
        updatedAt = now
        
        try Self.query().save(&self)
    }
    
    public mutating func delete() throws {
        if Self.softDeletable {
            deletedAt = Date()
            try save()
        } else {
            try Self.query().delete(self)
        }
    }
}
