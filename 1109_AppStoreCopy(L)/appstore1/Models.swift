// Data Modeling: Hierarchy
// FeaturedApps: bannerCategory, appCategories
// AppCategory: apps
// App

import UIKit

class FeaturedApps: NSObject {
    
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            
            for dict in value as! [[String: AnyObject]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
            
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(_ completionHandler: @escaping (FeaturedApps) -> ()) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            
            do {
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json as! [String: AnyObject])
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredApps)
                })
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
    }
}

class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
    var screenshots: [String]?
    var desc: String?
    var appInformation: AnyObject?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            self.desc = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}
