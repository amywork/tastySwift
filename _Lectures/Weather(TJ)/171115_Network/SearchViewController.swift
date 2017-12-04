
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var tempArray = ["Seoul", "Pusan", "London" ,"LA", "asdfg"]
    
    var searchController: UISearchController?
    
    var cityList: [CityData] = []
    var cityNameArray: [String] = []
    var filteredCityNameArray: [String] = []
    var cityName: String = "Seoul"
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var citySerchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.loadingIndicator.startAnimating()
        //json 데이터를 글로벌 쓰레드로 값을 받아옴
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "CityList", ofType: "json"),
                let contents = try? String(contentsOfFile: path),
                let data = contents.data(using: .utf8) {
                let cityDic = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                for city in cityDic {
                    self.cityList.append(CityData(cityDic: city)!)
                }
                DispatchQueue.main.async {
                    self.cityTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    print(self.cityNameArray)
                    print(self.cityList.count)
                    self.setupSearchBar()
                }
            }
        }
    }
    
    //기본적인 UI 셋팅
    func setupUI() {
        citySerchBar.backgroundColor = .clear
        citySerchBar.barTintColor = UIColor(red: 78/255, green: 85/255, blue: 94/255, alpha: 0.9)
        cityTableView.backgroundColor = UIColor(red: 78/255, green: 85/255, blue: 94/255, alpha: 0.9)
    }
    
    //searchbar 셋팅
    func setupSearchBar() {
        citySerchBar.delegate = self
        for list in 0 ... (cityList.count - 1){
            cityNameArray.append(cityList[list].city)
        }
        filteredCityNameArray = cityNameArray
    }
    
//    //백버튼 눌렀을 때 -> 현재까지는 사용 X
//    @IBAction func backButtonAction(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    //서치하는 순간 다운...
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            self.tempArray = self.tempArray.filter({ (array: String) -> Bool in
//                if self.tempArray.contains(self.citySerchBar.text!)
//                {
//                    return true
//                }
//                else
//                {
//                    return false
//                }
//                
//            })
//        self.cityTableView.reloadData()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackSegue" {
            let destinationViewController = segue.destination as! ViewController
            destinationViewController.cityName = cityName
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
        //return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityCell
        cell.cityNameLb.text = self.cityList[indexPath.row].city
//        cell.cityNameLb.text = self.tempArray[indexPath.row]
        return cell
    }
    
    //우선은 눌렀을 때 변수 값만 저장
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityName = self.cityList[indexPath.row].city

        //self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
