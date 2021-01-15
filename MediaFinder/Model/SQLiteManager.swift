//
//  SQLiteManager.swift
//  MediaFinder
//
//  Created by Mohamed on 12/30/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation
import SQLite
class SQLiteManager{
    var DataBase: Connection!
    let usersTable = Table("users")
    let searchTable = Table("search")
    let mediaTypeTable = Table("mediaType")
    let id = Expression<Int>("id")
    let user = Expression<Data>("user")
    let media = Expression<Data>("media")
    let mediaType = Expression<String>("mediaType")
    let scStatus = Expression<Int>("scStatus")
    
    private static let sharedInstance = SQLiteManager()
    
    static func shared() -> SQLiteManager {
        return SQLiteManager.sharedInstance
    }
    
    //MARK:- user Table
    func DataBaseSetup() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("DataBase").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.DataBase = database
        } catch {
            print(error)
        }
    }
    
    func creatUserTable() {
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.user)
        }
        do {
            try self.DataBase.run(createTable)
            print("user table created")
        } catch {
            print(error)
        }
    }
    
    func insertUser(user: User) {
        let encoder = JSONEncoder()
        if  let encoded = try? encoder.encode(user) {
            let inserUser = self.usersTable.insert(self.user <- encoded)
            do {
            try self.DataBase.run(inserUser)
            print("user inserted")
        } catch {
            print(error)
            }
        }
    }

    func getUser() -> User? {
        do {
            let users = try self.DataBase.prepare(self.usersTable)
            for user in users {
                let savedUser = user[self.user]
                let decoder = JSONDecoder()
                if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                    return loadedUser
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func deleteUser() {
            print("user deleted")
                let users = self.usersTable
                let deleteUser = users.delete()
                do {
                    try self.DataBase.run(deleteUser)
                } catch {
                    print(error)
                }
            }
    
    //MARK:- Search Table
    
    func creatSearchTable() {
           let createTable = self.searchTable.create { (table) in
                table.column(self.id, primaryKey: true)
                table.column(self.media)
           }
           do {
               try self.DataBase.run(createTable)
               print("search table created")
           } catch {
               print(error)
           }
       }

   func insertLastSearchResult(mediaArr: [Media]) {
        let encoder = JSONEncoder()
        if  let encodedMedia = try? encoder.encode(mediaArr) {
            let insertedMedia = self.searchTable.insert(self.media <- encodedMedia)
            do {
            try self.DataBase.run(insertedMedia)
            print("SEARCH INSERTED")
        } catch {
            print(error)
            }
        }
    }

    func getLastSearchResult() -> [Media]? {
        do {
            let searches = try self.DataBase.prepare(self.searchTable)
            for search in searches {
                let savedSearch = search[self.media]
                let decoder = JSONDecoder()
                if let loadedSearch = try? decoder.decode([Media].self, from: savedSearch) {
                    return loadedSearch
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func deleteLastSearch() {
        print("last search deleted")
        let search = self.searchTable
        let deleteSearch = search.delete()
        do {
            try self.DataBase.run(deleteSearch)
        } catch {
            print(error)
        }
    }
}
