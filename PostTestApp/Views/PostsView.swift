//
//  PostsView.swift
//  PostTestApp
//
//  Created by Shahzaib Maqbool on 10/01/2023.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var badgeNumber: Int
    @State private var postList = [Post]()
    var body: some View {
        NavigationView
        {
            VStack(alignment: .leading)
            {
                ScrollView(showsIndicators: false) {
                    ForEach(postList) { post in
                        
                        PostListRow(badgeNumber: $badgeNumber, viewModel: .init(post: post))
                        
                    }
                }
                
                .padding(10)
                
            }
            .frame(alignment: .leading)
        }
        .onAppear {
            self.viewModel.loadAllPosts(dataResult: { (success, data) in
               
                postList = viewModel.posts
                print("postList \(data)")
            })
            
        }
        
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView(viewModel: .init())
//    }
//}
