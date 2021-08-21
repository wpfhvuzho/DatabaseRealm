//
//  Memo.swift
//  DatabaseRealm
//
//  Created by 高橋　龍 on 2021/08/21.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
