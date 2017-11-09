// Singleton DataCenter Object Class

import Foundation
class DataCenter {
    
    static var main: DataCenter = DataCenter()
    var documentDirectory: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    // MARK: - data Property
    var settingDataList:[SettingData] = []
    var exploreDataList:[ExploreData] = []
    var stackDataList:[StackData] = []
  
    // MARK: - init with load data
    private init() {
        loadSettingData()
        loadExploreData()
    }
    
    // MARK: - load data method
    func loadSettingData() {
        let settingDataURL = documentDirectory.appendingPathComponent("Settings.plist")
        let settingDataPath = settingDataURL.path
        print(settingDataPath)
        
        if !FileManager.default.fileExists(atPath: settingDataPath) {
            guard let plistURL = Bundle.main.url(forResource: "Settings", withExtension: "plist") else { return }
            try! FileManager.default.copyItem(at: plistURL, to: settingDataURL)
        }
        
        guard let settingDataArr = NSArray(contentsOf: settingDataURL) as? [[String:Any]] else { return }
        for settingDataDic in settingDataArr {
            self.settingDataList.append(SettingData(with: settingDataDic))
        }
    }
    
    
    func loadExploreData() {
        let exploreDataURL = documentDirectory.appendingPathComponent("ExploreData.plist")
        let exploreDataPath = exploreDataURL.path
        
        if !FileManager.default.fileExists(atPath: exploreDataPath) {
            guard let plistURL = Bundle.main.url(forResource: "ExploreData", withExtension: "plist") else { return }
            try! FileManager.default.copyItem(at: plistURL, to: exploreDataURL)
        }
        
        guard let dataArr = NSArray(contentsOf: exploreDataURL) as? [[String:String]] else { return }
        for dataDic in dataArr {
            guard let data = ExploreData(with: dataDic) else { return }
            self.exploreDataList.append(data)
        }
    }

}
