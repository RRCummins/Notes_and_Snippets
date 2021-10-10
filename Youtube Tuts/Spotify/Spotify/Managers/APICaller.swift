//
//  APICaller.swift
//  Spotify
//
//  Created by Ryan Cummins on 2/22/21.
//

import Foundation
import CoreImage

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    //MARK: - Albums
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                } // data guard
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            } // task completion
            task.resume()
        } // createRequest completion
    } // getAlbumDetails
    
    
    //MARK: - Playlists
    
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                } // data guard
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            } // task completion
            task.resume()
        } // createRequest completion
    } // getPlaylistDetails
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(
            with: URL(string:  Constants.baseAPIURL + "/me/playlists/?limit=50"),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
//                        print(result)
                        completion(.success(result.items))
                    } catch {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.createRequest(
                    with: URL(string: Constants.baseAPIURL + "/users/\(profile.id)/playlists"), type: .POST) { baseRequest in
                        var request = baseRequest
                        let json = [
                            "name": name,
                        ]
                        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                        let task = URLSession.shared.dataTask(with: request) { data, _, error in
                            guard let data = data, error == nil else {
                                completion(false)
                                return
                            }
                            do {
                                let results = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                if let response = results as? [String : Any], response["id"] as? String != nil {
                                    print("Created")
                                    completion(true)
                                } else {
                                    print("Failed to get ID")
                                    completion(false)
                                }
//                                print(results)
                            } catch {
                                completion(false)
                                print(error.localizedDescription)
                            }
                            
                        }
                        task.resume()
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func addTrackToPlaylist(
        track: AudioTrack,
        playlist: Playlist,
        completion: @escaping (Bool) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"),
            type: .POST
        ) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": [
                    "spotify:track:\(track.id)"
                ]
            ]
            print(json)
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Adding...")
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(false)
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(result)
                    if let response = result as? [String:Any],
                       response["snapshot_id"] as? String != nil {
                        print("Added Song")
                        completion(true)
                    } else {
                        print("Failed to add Song")
                        completion(false)
                    }
                    print("Failed to add Song")
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            task.resume()
            
        }
        
    }
    
    public func removeTrackFromPlaylist(rack: AudioTrack,
                                        playlist: Playlist,
                                        completion: @escaping (Bool) -> Void) {
        
    }
    
    
    //MARK: - Profile
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET
        ) { (baseRequest) in
            let task = URLSession.shared.dataTask(with: baseRequest) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    //                    let result = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
//                    print(result, #fileID, #function, #line)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription, #fileID, #function, #line)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Browse
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        // "/browse/new-releases" is the base request and "?limit=50" is an optional return limit
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    //                    print(result, #fileID, #function, #line)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>)) -> Void) {
        //        /browse/featured-playlists
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"),
                      type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
//                    print(result, #fileID, #function, #line)
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
                      type: .GET) { (request) in
            //                print(request.url?.absoluteString)
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    //                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                    //                        print(json, #fileID, #function, #line)
                    //                        print(result, #fileID, #function, #line)
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getRecommendedGeneres(completion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
                      type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                    //                    print(json, #fileID, #function, #line)
                    //                    print(result, #fileID, #function, #line)
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Category
    
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
//                        print(result)
                        completion(.success(result.categories.items))
                    } catch  {
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
    public func getCategoryPlaylists(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        let result = try JSONDecoder().decode(CategoryPlaylistResponse.self, from: data)
                        let playlists = result.playlists.items
//                        print(playlists)
                        completion(.success(playlists))
                    } catch  {
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
    // MARK: - Search
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL+"/search?limit=8&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            type: .GET) { request in
                print(request)
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        let result = try JSONDecoder().decode(SearchResultsResponse.self, from: data)
                        
                        var searchResults: [SearchResult] = []
                        
                        searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0) }))
                        searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0) }))
                        searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0) }))
                        searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0) }))
                        
//                        print(result)
                        completion(.success(searchResults))
                    } catch {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
    // MARK: - Private
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { (token) in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
}
