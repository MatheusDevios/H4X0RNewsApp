//
//  NetworkManager.swift
//  H4X0RNewsApp
//
//  Created by Matheus Diniz on 14/03/2022.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page"){
            let sesion = URLSession(configuration: .default)
            let task = sesion.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do{
                         let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }

                        } catch {
                            print(error)
                        }
                    }
            }
        }
            task.resume()
    }
}
}
