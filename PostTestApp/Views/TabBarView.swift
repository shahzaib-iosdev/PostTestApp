//
//  TabBarView.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI

struct TabBarView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:  \Posts.id, ascending: true)],
        animation: .default)
    private var postsOffline: FetchedResults<Posts>
    
    
  @State private var badgeNumber: Int = 0
  private var badgePosition: CGFloat = 1
  private var tabsCount: CGFloat = 1

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottomLeading) {
        // TabView
          TabView {
              PostsView(viewModel: .init(), badgeNumber: $badgeNumber)
                  .tabItem {
                      Label("Posts", image: "posts")
                  }
                  .tag(1)
              OfflinePostsView( badgeNumber: $badgeNumber)
                  .tabItem {
                      Label("Offline Posts", image: "posts")
                  }
                 // .badge(5)
                  .tag(2)
          }

        // Badge View
        ZStack {
          Circle()
            .foregroundColor(.red)

          Text("\(self.badgeNumber)")
            .foregroundColor(.white)
            .font(Font.system(size: 12))
        }
        .frame(width: 20, height: 20)
        .offset(x: ( ( 3 * self.badgePosition) - 1 ) * ( (geometry.size.width+55) / ( 3 * self.tabsCount ) ), y: -27)
        .opacity(self.badgeNumber == 0 ? 0 : 1)
      }
      .onAppear
        {
            self.badgeNumber = self.postsOffline.count
        }
    }
  }
}

//struct TabBarView1: View {
//    var body: some View {
//        TabView {
//            PostsView(viewModel: .init())
//                .tabItem {
//                    Label("Posts", systemImage: "pencil")
//                }
//                .tag(1)
//            OfflinePostsView()
//                .tabItem {
//                    Label("Offline Posts",systemImage: "pencil")
//                }
//               // .badge(5)
//                .tag(2)
//        }
//
//
//    }
//}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
