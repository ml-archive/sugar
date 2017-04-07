import Vapor
import Fluent

extension Entity {
    /// Saves or modifies (if already exists) a model given a value and field.
    ///
    /// - Parameters:
    ///    - value: The value to look for.
    ///    - field: The field to look in.
    public mutating func saveOrModify(
        given value: NodeRepresentable,
        for field: String,
        beforeSave: ((Self, Self) -> ())? = nil
    ) throws {
        return try saveOrModify(given: [field: value], beforeSave: beforeSave)
    }
    /// Saves of modifies (if already exists) a model given multiple values and fields.
    ///
    /// - Parameter values: The list of values and fields to look for.
    /// - Throws: On db errors.
    public mutating func saveOrModify(
        given values: [String: NodeRepresentable],
        beforeSave: ((Self, Self) -> ())? = nil
    ) throws {
        var query = try Self.query()
        for (field, value) in values {
            query = try query.filter(field, value)
        }
        if let instance = try query.first() {
            id = instance.id
            exists = true
            if let beforeSave = beforeSave {
                beforeSave(instance, self)
            }
        }
        try save()
    }
    
    
    public mutating func saveIfUnique(given values: [String: NodeRepresentable]) throws {
        var query = try Self.query()
        
        for (field, value) in values {
            query = try query.filter(field, value)
        }
        
        guard try query.first() == nil else {
            return 
        }
        
        try save()
    }
}
// !!! WARNING: Duplicate methods due to the way Swift generics work. 
extension NodesModel {
    /// Saves or modifies (if already exists) a model given a value and field.
    ///
    /// - Parameters:
    ///    - value: The value to look for.
    ///    - field: The field to look in.
    public mutating func saveOrModify(
        given value: NodeRepresentable,
        for field: String,
        beforeSave: ((Self, Self) -> ())? = nil
    ) throws {
        return try saveOrModify(given: [field: value], beforeSave: beforeSave)
    }
    
    /// Saves of modifies (if already exists) a model given multiple values and fields.
    ///
    /// - Parameter values: The list of values and fields to look for.
    /// - Throws: On db errors.
    public mutating func saveOrModify(
        given values: [String: NodeRepresentable],
        beforeSave: ((Self, Self) -> ())? = nil
    ) throws {
        var query = try Self.query()
        for (field, value) in values {
            query = try query.filter(field, value)
        }
        
        if let instance = try query.first() {
            id = instance.id
            exists = true
            if let beforeSave = beforeSave {
                beforeSave(instance, self)
            }
        }
        
        try save()
    }
    
    
    public mutating func saveIfUnique(given values: [String: NodeRepresentable]) throws {
        var query = try Self.query()
        
        for (field, value) in values {
            query = try query.filter(field, value)
        }
        
        if var model = try query.first() {
            guard Self.softDeletable else {
                return
            }
            model.deletedAt = nil
            try model.save()
            return
        }
        
        try save()
    }
}
