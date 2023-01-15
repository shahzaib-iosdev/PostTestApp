//
//  OfflinePostsView.swift
//  PostTestApp
//
//  Created by Shahzaib Maqbool on 10/01/2023.
//

import SwiftUI
import CoreData
struct OfflinePostsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:  \Posts.id, ascending: true)],
        animation: .default)
    private var postsOffline: FetchedResults<Posts>
    @State private var postList = [Post]()
    @State private var post:Post?
    @Binding var badgeNumber: Int
    var body: some View {
        NavigationView
        {
            VStack
            {
                ScrollView(showsIndicators: false) {
                    let allPostts: [Post] = convertToPost()
                    ForEach(allPostts) { pst in
                        PostListRow(badgeNumber: $badgeNumber, viewModel: .init(post: pst),isFromOfflineTab: true)
                    }
                }
                .padding(10)
                
            }
        }
    }
    
    
}
extension OfflinePostsView
{
    func convertToPost() -> [Post] {
        var allposts = [Post]()
        postsOffline.forEach { pst in
            
            allposts.append(Post(managedObject: pst)!)
        }
        return allposts
    }
}
//struct OfflinePostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OfflinePostsView(badgeNumber: Binding(0))
//    }
//}
