//
//  PostDetailView.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI
import CoreData

struct PostDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:  \Posts.id, ascending: true)],
        animation: .default)
    private var postsOffline: FetchedResults<Posts>
    
    @State var isFromOfflineTab = false
    @Binding var badgeNumber: Int
    
    @ObservedObject var viewModel: PostDetailViewModel
    @State var openCommentspage = false
    var body: some View {
        VStack(alignment: .leading,spacing: 10)
        {
            HStack
            {
                Text("\(viewModel.post.title)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                
                
            }
            
            HStack
            {
                Text("\(viewModel.post.body)")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            if !isFromOfflineTab
            {
                HStack
                {
                    
                    
                    VStack
                    {
                        Button("Comments")
                        {
                            openCommentspage = true
                        }
                        .frame(width: 120,height: 30)
                        .foregroundColor(Color.black)
                        .font(.system(size: 14, weight: .heavy))
                        
                    }
                    .padding()
                    .frame(height: 35)
                    .cornerRadius(15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 2)
                        
                    )
                    let allPosts: [Post] = convertToPost()
                    if allPosts.contains(viewModel.post)
                    {
                        HStack
                        {
                            Button("Saved for Offline")
                            {
                                //addItem()
                            }
                            .frame(width: 130, height: 35)
                            .foregroundColor(Color.white)
                            .font(.system(size: 13, weight: .heavy))
                            .cornerRadius(2)
                            .background(
                                RoundedRectangle(cornerRadius: 17)
                                    .fill(Color.gray)
                                    .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 2)
                            )
                            .padding(.leading)
                        }
                    }
                    else
                    {
                        HStack
                        {
                            Button("Save for Offline")
                            {
                                addItem()
                                self.badgeNumber += 1
                            }
                            .frame(width: 120, height: 35)
                            .foregroundColor(Color.white)
                            .font(.system(size: 13, weight: .heavy))
                            .cornerRadius(2)
                            .background(
                                RoundedRectangle(cornerRadius: 17)
                                    .fill(Color.black)
                                    .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 2)
                            )
                            .padding(.leading)
                        }
                    }
                   
                    
                }
                .padding()
            }
                
            Spacer()
        }
        .padding()
        //        .onAppear {
        //            self.viewModel.loadPostDetails(withID: viewModel.post.id , dataResult: { (success, data) in
        //
        //                //postList = viewModel.postDetail
        //                print("postDetail \(data)")
        //            })
        //
        //        }
        NavigationLink(destination: PostCommentsView(viewModel: .init(post: viewModel.post))
            .navigationBarBackButtonHidden(false), isActive: $openCommentspage){
                
                
            }
    }
    
    private func addItem() {
        withAnimation {
            let postOffline = Posts(context: viewContext)
            postOffline.id = Int32(viewModel.post.id)
            postOffline.title = viewModel.post.title
            postOffline.body = viewModel.post.body
            
            postOffline.userId = Int32(viewModel.post.id)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
extension PostDetailView
{
    func convertToPost() -> [Post] {
        var allposts = [Post]()
        postsOffline.forEach { pst in

            allposts.append(Post(managedObject: pst)!)
        }
        return allposts
    }
}
//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}
