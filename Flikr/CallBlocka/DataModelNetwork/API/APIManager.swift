import UIKit
import Alamofire

import CodableAlamofire



let kPaginationLoad : Int = 10

class APIManager {
    static let shared = APIManager()
    static let memoryCapacity = 500 * 1024 * 1024
    static let diskCapacity = 500 * 1024 * 1024
    static let sharedInstance = APIManager()
    static  let cache = CustomURLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "Cache-01")
    
    var manager: Alamofire.SessionManager

    init() {

        let configuration = URLSessionConfiguration.default
        let defaultHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]

        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = APIManager.cache

        let baseAPIURL: NSURL = NSURL(string: "https://api.flickr.com/services/rest/")!

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            baseAPIURL.host!: .disableEvaluation,
        ]

        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)

        // TODO: Need to find a way to plug in expiration parameter
        manager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
        
    }

    
    // Why this? - this is crafting multiple API calls to get variety of results to mash together into landing page
    // It's possible to eagerly fetch this content before any views appear - so we use lose coupling to broadcast when data comes in
    // optimisations could include reducing number of images to fetch
    func fetchLandingContent(){

        let searchTitle = "office"
        searchFlickrForTerm(searchTitle) { (photos, error)  in

            let channel = FlikrChannel(name: searchTitle, photos: photos)
            DM.flikrChannels.append(channel)
            Notificator.fireNotification(kFlikrLoaded)
        }

    }
    
    // Flickr API - https://www.flickr.com/services/apps/create/noncommercial/?
    // https://www.flickr.com/services/api/explore/flickr.photos.search

    func searchFlickrForTerm(_ searchText:String, completion:@escaping (_ photos: [Photo], _ error: NSError?) -> ()){
        let searchUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d23df03e03b9043a43b88e43af741293&per_page=10&format=json&nojsoncallback=1&safe_search=1&text="
        
        let urlStr = "\(searchUrl)\(searchText)"
 
        
        manager.request(urlStr).responseDecodableObject { (response: DataResponse<PicCollection>) in

            switch response.result {
            case .success(let result):
                if let myPhotos = result.photos.photo{
                    completion(myPhotos,nil)
                }else{
                      completion([],nil)
                }

            case .failure(let error):
                  completion([],error as NSError)
            }

        }

        
    }
    

   
    
   
    
}


