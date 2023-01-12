//
//  PostListRowViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI

class PostListRowViewModel: ObservableObject {
        
        let post: Post
        
        init(post: Post) {
            self.post = post
        }
        
}
