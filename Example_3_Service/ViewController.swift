import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tab: UITableView!
    
   // var ar = ["a","s","f","c","x"]
    var arr = [[String:Any]]()
    let url = "https://api.androidhive.info/contacts/"
    override func viewDidLoad() {
        super.viewDidLoad()
        tab.dataSource = self
        tab.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        callData(url: url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func callData(url :String)  {
        Alamofire.request(url, method: .get).responseData { (response) in
            if let val = response.result.value{
                let swiftyJson = JSON(val)
               // print(swiftyJson)
                let x  = swiftyJson["contacts"].arrayObject
                //print(x!)
                self.arr = x as! [[String:Any]]
                if self.arr.count > 0{
                    self.tab.reloadData()
                }
             
             
            }
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cl", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = arr[indexPath.row]["email"] as? String
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

