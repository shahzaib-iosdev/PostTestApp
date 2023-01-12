//
//  Models.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import Foundation
import SwiftUI

struct Post: Equatable, Codable,Identifiable {
    var id: Int
    var title: String
    var body: String
}
struct Comments: Equatable, Codable,Identifiable {
    
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
extension Post {

  
  init?(managedObject: Posts) {

    let id = managedObject.id,
      title = managedObject.title, body = managedObject.body

      self.init(id: Int(id), title: title ?? "", body: body ?? "")
  }
}
