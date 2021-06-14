//
//  HttpService.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import Foundation

enum BaseUrl: String {
    case githubApi = "https://api.github.com"
}

enum Endpoint: String {
    case searchRepositories = "/search/repositories"
}

struct HttpService {
    let baseUrl: BaseUrl
    
    init(baseUrl: BaseUrl = .githubApi) {
        self.baseUrl = baseUrl
    }
    
    func get<T: Decodable>(endpoint: Endpoint, parameters: [String: String], completion: @escaping (T?, Error?) -> Void) {
        guard let url = buildUrl(with: endpoint, parameters: parameters) else {
            print("Invalid Url")
            //todo: call completion block
            return
        }
        
        //todo: implement cache for url
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    //cache
                    DispatchQueue.main.async {
                        completion(decodedResponse, nil)
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
            
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    completion(nil, err)
                }
            }
        }.resume()
        
        
    }
    
    
    func buildUrl(with endpoint: Endpoint, parameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(string: baseUrl.rawValue) else {
            return nil
        }
        
        urlComponents.queryItems = parameters.map {
            return URLQueryItem(name: $0, value: $1)
        }
        
        guard var url = urlComponents.url else {
            return nil
        }
        
        url.appendPathComponent(endpoint.rawValue)
        return url
    }
    
}
