//
//  SQLiteManager.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//

import SQLite

class SQLiteManager {
    static let sqliteManager = SQLiteManager()//singleton
    
    //a connetion using a thread
    func getDB() -> Connection?{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try? Connection("\(path)/db.sqlite3")
        db?.busyTimeout = 5 //avoid infinite waiting

        return db!
    }
    
    //CRUD
}
