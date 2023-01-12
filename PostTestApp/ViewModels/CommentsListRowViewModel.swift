//
//  CommentsViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 11/01/2023.
//

import SwiftUI

class CommentsListRowModel: ObservableObject {
        
        let comments: Comments
        
        init(comments: Comments) {
            self.comments = comments
        }
}
