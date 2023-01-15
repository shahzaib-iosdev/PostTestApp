//
//  PostDetailViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI
import Alamofire

class PostDetailViewModel: ObservableObject {
    @Published var post: Post
    //@Published var postDetail: Post?
    
    init(post:Post) {
        self.post = post
        //self.postDetail =
    }
    
    //      func loadPostDetails(withID postID: Int, dataResult: @escaping(_ success: Bool, _ data: Any) -> Void) {
    //
    //          let path: String = baseURL() + "posts/\(postID)"
    //          DispatchQueue.global(qos: .background).async {
    //              AF.request(path, method: .get)
    //                  .responseData {
    //                      response in
    //                      switch response.result {
    //                      case .success(let value):
    //                          let str = String(decoding: value, as: UTF8.self)
    //                          print("The value \(str) \(value)")
    //                              do {
    //                                  let data = value
    //                                      self.postDetail = try! JSONDecoder().decode(Post.self, from: data)
    //                                      //self.posts = self.posts.sorted(by: { $0.id > $1.id})
    //                                      dataResult(true, "Success")
    //
    //                              } catch {
    //                                  dataResult(false, "There are no posts at the moment")
    //                              }
    //                      case .failure(let err):
    //                          dataResult(false, err.localizedDescription)
    //                      }
    //                  }
    //          }
    //      }
}


