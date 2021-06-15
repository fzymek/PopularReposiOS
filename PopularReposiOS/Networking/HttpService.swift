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

struct Endpoint {
    
    private init() {
        
    }
    
    static func searchRepositiries() -> String {
        return "/search/repositories"
    }
    
    static func repositoryEndpoint(owner: String, name: String) -> String {
        return "/repos/\(owner)/\(name)"
    }
}

enum HttpError: Error {
    case invalidUrl
}

protocol HttpService {
    func get<T: Decodable>(endpoint: String, parameters: [String: String], completion: @escaping (T?, Error?) -> Void) -> URLSessionDataTask?
}

struct GithubRESTService: HttpService {
    
    let baseUrl: BaseUrl
    
    static let shared = GithubRESTService()
    
    init(baseUrl: BaseUrl = .githubApi) {
        self.baseUrl = baseUrl
    }
    
    func get<T: Decodable>(endpoint: String, parameters: [String: String], completion: @escaping (T?, Error?) -> Void) -> URLSessionDataTask? {
        guard let url = buildUrl(with: endpoint, parameters: parameters) else {
            print("Invalid Url")
            DispatchQueue.main.async {
                completion(nil, HttpError.invalidUrl)
            }
            return nil
        }
        
        //todo: implement cache for url
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        print(request)
        return URLSession.shared.dataTask(with: request) {data, response, error in
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
        }
        
        
    }
    
    func buildUrl(with endpoint: String, parameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(string: baseUrl.rawValue) else {
            return nil
        }
        
        urlComponents.queryItems = parameters.map {
            return URLQueryItem(name: $0, value: $1)
        }
        
        guard var url = urlComponents.url else {
            return nil
        }
        
        url.appendPathComponent(endpoint)
        return url
    }
    
}
