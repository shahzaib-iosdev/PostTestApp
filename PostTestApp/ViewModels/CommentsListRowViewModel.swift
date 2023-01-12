//
//  CommentsViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 11/01/2023.
//

import SwiftUI

extension CommentsListRow {
    
    class ViewModel: ObservableObject {
        
        let comments: Comments
        
        init(comments: Comments) {
            self.comments = comments
        }
    }
}
