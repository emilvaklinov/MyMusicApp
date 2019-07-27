

import Foundation

private struct API {
    private static let base = "https://itunes.apple.com/"
    private static let search = API.base + "search"
    private static let lookup = API.base + "lookup"
    
    static let searchURL = URL(string: API.search)!
    static let lookupURL = URL(string: API.lookup)!
}

private func createRequest(url: URL, params: [String: Any]) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let body = params.map{ "\($0)=\($1)" }
        .joined(separator: "&")
    request.httpBody = body.data(using: .utf8)
    
    return request
}

private func createSearchRequest(term: String) -> URLRequest {
    let params = ["term": term, "media": "music", "entity": "song"]
    return createRequest(url: API.searchURL, params: params)
}

private func createLookupRequest(id: Int) -> URLRequest {
    let params = ["id": id]
    return createRequest(url: API.lookupURL, params: params)
}

class MediaService {
    static func getMediaList(term: String, completion: @escaping (Bool, [MediaBrief]?) -> Void) {
        
        let session = URLSession(configuration: .default)
        let request = createSearchRequest(term: term)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let results = responseJSON["results"] as? [AnyObject] {
                    
                    var list = [MediaBrief]()
                    for i in 0 ..< results.count {
                        guard let song = results[i] as? [String: Any] else {
                            continue
                        }
                        
                        if let id = song["trackId"] as? Int,
                            let title = song["trackName"] as? String,
                            let artistName = song["artistName"] as? String,
                            let artworkUrl = song["artworkUrl100"] as? String {
                            let mediaBrief = MediaBrief(id: id, title: title, artistName: artistName, artworkUrl: artworkUrl)
                            
                            list.append(mediaBrief)
                        }
                    }
                    
                    completion(true, list)
                }
                else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    static func getMedia(id: Int, completion: @escaping (Bool, Media?) -> Void) {
        let session = URLSession(configuration: .default)
        let request = createLookupRequest(id: id)
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let results = responseJSON["results"] as? [AnyObject] {
                    
                    if results.count > 0,
                        let song = results[0] as? [String: Any],
                        let id = song["trackId"] as? Int,
                        let title = song["trackName"] as? String,
                        let artistName = song["artistName"] as? String,
                        let artworkUrl = song["artworkUrl100"] as? String,
                        let sourceUrl = song["trackViewUrl"] as? String {
                        
                        let media = Media(id: id, title: title, artistName: artistName, artworkUrl: artworkUrl, sourceUrl: sourceUrl)
                        media.collection = song["collectionName"] as? String
                        completion(true, media)
                    }
                    else {
                        completion(false, nil)
                    }
                }
                else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    // To get the images
    static func getImage(imageUrl: URL, completion: @escaping (Bool, Data?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: imageUrl) { (data, response, error) in
            if let data = data, error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(true, data)
            }
            else {
                completion(false, nil)
            }
        }
        task.resume()
    }
}
