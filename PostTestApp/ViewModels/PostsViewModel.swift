//
//  PostsViewModel.swift
//  PostTestApp
//
//  Created by CrownSDS on 10/01/2023.
//

import SwiftUI
import Alamofire

class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post]
    @Published var error: Error?
    @Published var success = false
    init() {
        self.posts = [Post]()
    }
    
    func loadAllPosts(dataResult: @escaping(_ success: Bool, _ data: Any) -> Void) {
        
        let path: String = baseURL() + "posts"
        DispatchQueue.global(qos: .background).async {
            AF.request(path, method: .get)
                .responseData {
                    response in
                    switch response.result {
                    case .success(let value):
                        do
                        {
                            self.posts = try! JSONDecoder().decode([Post].self, from: value)
                            if self.posts.count == 0
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
                            dataResult(false, "There are no posts at the moment")
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
