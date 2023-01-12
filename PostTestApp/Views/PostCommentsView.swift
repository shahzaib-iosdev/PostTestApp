//
//  PostCommentsView.swift
//  PostTestApp
//
//  Created by CrownSDS on 11/01/2023.
//

import SwiftUI

struct PostCommentsView: View {
    
    @ObservedObject var viewModel: PostCommentsViewModel
    var body: some View {
        VStack
        {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.comments) { comments in
                    
                    CommentsListRow(viewModel: .init(comments: comments))
                }
            }
            .padding(10)
            
        }
        .onAppear {
            self.viewModel.getPostComments(withID: viewModel.post.id , dataResult: { (success, data) in
                
                print("getPostComments \(data)")
            })
            
        }
    }
}

//struct PostCommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCommentsView(viewModel: .init(post: .))
//    }
//}
