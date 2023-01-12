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
        @Published var isLinkActive: [String: Bool] = [:]
        
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
                                self.posts = self.posts.sorted(by: { $0.id > $1.id})
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
