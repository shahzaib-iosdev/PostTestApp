//
//  PostCommentsViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 11/01/2023.
//

import SwiftUI
import Alamofire

extension PostCommentsView {
    
    class ViewModel: ObservableObject {
        
        @Published var comments: [Comments]
        @Published var post: Post
        
        init(post:Post) {
            
            self.post = post
            self.comments = [Comments]()
        }
        
        func getPostComments(withID postID: Int, dataResult: @escaping(_ success: Bool, _ data: Any) -> Void) {
            
            let path: String = baseURL() + "posts/\(postID)/comments/"
            DispatchQueue.global(qos: .background).async {
                AF.request(path, method: .get)
                    .responseData {
                        response in
                        switch response.result {
                        case .success(let value):
                            do {
                                self.comments = try! JSONDecoder().decode([Comments].self, from: value)
                                self.comments = self.comments.sorted(by: { $0.id > $1.id})
                                dataResult(true, "Success")
                                
                            }
                            catch {
                                dataResult(false, "There are no posts at the moment")
                            }
                        case .failure(let err):
                            dataResult(false, err.localizedDescription)
                        }
                    }
            }
        }
    }
}
