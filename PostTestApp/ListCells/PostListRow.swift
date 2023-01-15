//
//  PostListRow.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI
import CoreData
struct PostListRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var badgeNumber: Int
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:  \Posts.id, ascending: true)],
        animation: .default)
    private var postsOffline: FetchedResults<Posts>
    
    @ObservedObject var viewModel: PostListRowViewModel
    @State var openDetailspage = false
    @State var isFromOfflineTab = false
    
    @State var showingAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .failure
    enum ActiveAlert {
        case success
        case failure
    }
    var body: some View {
        Color.gray.opacity(0.05)
        VStack(alignment: .leading,spacing: 10)
        {
            Button(action: {
                print("Okkkay")
                self.openDetailspage = true
                
            })
            {
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
                        let allPosts: [Post] = convertToPost()
                        if allPosts.contains(viewModel.post)
                        {
                            HStack
                            {
                                Button("Saved for Offline")
                                {
                                    
                                }
                                .frame(width: 130, height: 30)
                                .foregroundColor(Color.white)
                                .font(.system(size: 13, weight: .heavy))
                                .cornerRadius(2)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.gray)
                                        .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 2)
                                )
                                .padding(.top)
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
                                .frame(width: 120, height: 30)
                                .foregroundColor(Color.white)
                                .font(.system(size: 13, weight: .heavy))
                                .cornerRadius(2)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.black)
                                        .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 2)
                                )
                                .padding(.top)
                            }
                        }
                       
                    }
                }
                //.frame(height: 40)
                .padding()
            }
        }
        .frame(width: UIScreen.main.bounds.size.width - 30,alignment: .leading)
        .alert(isPresented: $showingAlert, content: {
            switch activeAlert {
            case .success:
                return Alert(title: Text("Success"), message: Text("Successfully saved for offline view"), dismissButton: .default(Text("OK")) {
                    print("Success")
                })
            case .failure:
                return Alert(title: Text("Error"), message: Text("Unable to save for offline, please try again"), dismissButton: .default(Text("OK")))
            }
        })
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.40), radius: 3, x: 0, y: 3)
        )
        NavigationLink(destination: PostDetailView(isFromOfflineTab: isFromOfflineTab, badgeNumber: $badgeNumber, viewModel: .init(post: viewModel.post))
            .navigationBarBackButtonHidden(false), isActive: $openDetailspage){
                
                
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
                activeAlert = .success
                showingAlert = true
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                activeAlert = .failure
                showingAlert = true
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                
            }
        }
    }
}
extension PostListRow
{
    func convertToPost() -> [Post] {
        var allposts = [Post]()
        postsOffline.forEach { pst in

            allposts.append(Post(managedObject: pst)!)
        }
        return allposts
    }
}
//struct PostListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PostListRow(viewModel: .init(post: Post))
//    }
//}
