import Vapor
import Fluent

extension Schema.Creator {
    
    /*
     MARK: DATETIME
     */
    
    /**
     Creates a DATETIME type
     - parameter name: name of column
     - parameter optional: make column optional
     - parameter unique: make column unique
     - parameter default: Default value
     */
    public func datetime(
        _ name: String,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "DATETIME", optional: optional, unique: unique, default: defaultValue)
    }
    
    // MARK: Timestamps
    /**
     Creates created_at & updated_at DATETIME
     */
    public func timestamps() {
        self.datetime("created_at", optional: true)
        self.datetime("updated_at", optional: true)
    }
    
    /**
     Creates deleted_at DATETIME
     */
    public func softDelete() {
        self.datetime("deleted_at", optional: true)
    }
    
    // MARK: DATE
    /**
     Creates a DATE type
     - parameter name: name of column
     - parameter optional: make column optional
     - parameter unique: make column unique
     - parameter default: Default value
     */
    public func date(
        _ name: String,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "DATE", optional: optional, unique: unique, default: defaultValue)
    }
    
    /*
     MARK: Numeric datatypes
     */
    
    public func integer(
        _ name: String,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        
        var typeSQL: String = "INTEGER"
        
        if (signed) {
            typeSQL += "(11)"
        } else {
            typeSQL += "(10) UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func tinyInteger(
        _ name: String,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "TINYINT"
        } else {
            typeSQL = "TINYINT UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func boolean(
        _ name: String,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "TINYINT(1) UNSIGNED", optional: optional, unique: unique, default: defaultValue)
    }
    
    public func smallInteger(
        _ name: String,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "SMALLINT"
        } else {
            typeSQL = "SMALLINT UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func mediumInteger(
        _ name: String,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "MEDIUMINT"
        } else {
            typeSQL = "MEDIUMINT UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func bigInteger(
        _ name: String,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "BIGINT"
        } else {
            typeSQL = "BIGINT UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func decimal(
        _ name: String,
        precision: UInt = 4,
        digits: UInt = 2,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "DECIMAL(" + String(precision) + "," + String(digits) + ")"
        } else {
            typeSQL = "DECIMAL(" + String(precision) + "," + String(digits) + ") UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func float(
        _ name: String,
        precision: UInt = 4,
        digits: UInt = 2,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "FLOAT(" + String(precision) + "," + String(digits) + ")"
        } else {
            typeSQL = "FLOAT(" + String(precision) + "," + String(digits) + ") UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    public func double(
        _ name: String,
        precision: UInt = 4,
        digits: UInt = 2,
        signed: Bool = true,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        var typeSQL: String = ""
        
        if (signed) {
            typeSQL = "DOUBLE(" + String(precision) + "," + String(digits) + ")"
        } else {
            typeSQL = "DOUBLE(" + String(precision) + "," + String(digits) + ") UNSIGNED"
        }
        
        self.custom(name, type: typeSQL, optional: optional, unique: unique, default: defaultValue)
    }
    
    /*
     MARK: String datatypes
     */
    
    public func char(
        _ name: String,
        length: UInt = 4,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "CHAR(" + String(length) + ")", optional: optional, unique: unique, default: defaultValue)
    }
    
    public func varchar(
        _ name: String,
        length: UInt = 255,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "VARCHAR(" + String(length) + ")", optional: optional, unique: unique, default: defaultValue)
    }
    
    public func text(
        _ name: String,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "TEXT", optional: optional, unique: unique, default: defaultValue)
    }
    
    public func longText(
        _ name: String,
        optional: Bool = false,
        unique: Bool = false,
        defaultValue: NodeRepresentable? = nil
        ) {
        self.custom(name, type: "LONGTEXT", optional: optional, unique: unique, default: defaultValue)
    }
    
    /*
     MARK: Index functions
     */
    /*
    public func foreign(
        parentTable: String,
        parentPrimaryKey: String,
        childTable: String,
        childForeignKey: String
        ) throws {
        let query: String = "ALTER TABLE " + childTable + " ADD CONSTRAINT " + childTable + "_" + parentTable + "_" + parentPrimaryKey + "_foreign FOREIGN KEY(" + childForeignKey + ") REFERENCES " + parentTable + "(" + parentPrimaryKey + ");"
        
        print(query)
        try drop.database!.driver.raw(query)
    }
    
    public func index(
        table: String,
        column: String
        ) throws {
        let query: String = "ALTER TABLE " + table + " ADD INDEX " + table + "_" + column  + "_index (" + column + ")"
        print(query)
        try drop.database!.driver.raw(query)
    }
    */
}
