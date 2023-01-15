//
//  PostCommentsViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 11/01/2023.
//

import SwiftUI
import Alamofire

class PostCommentsViewModel: ObservableObject {
    
    @Published var comments: [Comments]
    @Published var post: Post
    @Published var error: Error?
    @Published var success: Bool = false
    init(post:Post) {
        
        self.post = post
        self.comments = [Comments]()
    }
    
    func getPostComments(withID postID: Int, dataResult: @escaping(_ success: Bool, _ data: Any) -> Void) {
        
        let path: String = baseURL() + "posts/\(postID)/comments/"
        DispatchQueue.global(qos: .background).sync {
            AF.request(path, method: .get)
                .responseData {
                    response in
                    switch response.result {
                    case .success(let value):
                        do {
                            self.comments = try! JSONDecoder().decode([Comments].self, from: value)
                            if self.comments.count == 0
                            {
                                self.success = false
                                dataResult(false, "There are no comments at the moment")
                            }
                            else
                            {
                                self.success = true
                                dataResult(true, "Success")
                            }
                        }
                        catch {
                            self.success = false
                            dataResult(false, "There are no comments at the moment")
                        }
                    case .failure(let err):
                        self.success = false
                        self.error = err
                        dataResult(false, err.localizedDescription)
                    }
                }
        }
    }
}
