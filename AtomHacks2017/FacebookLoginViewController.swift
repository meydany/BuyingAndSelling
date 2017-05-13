import UIKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseDatabase

var facebookName: String = ""
var facebookPicture: UIImage = UIImage()
var facebookUserID: String = ""

class FacebookLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let contentView =  Bundle.main.loadNibNamed("FacebookLogin", owner: self, options: nil)?[0] as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.view.bounds
        
        self.view.addSubview(contentView)
        getItemCount()
    }
    
    @IBAction func loginFacebook(_ sender: Any) {
        loginButtonClicked()
    }
 
    func getItemCount() {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Listings").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
            let value = snapshot.value as! [String: [String: String]]
            CELL_COUNT = value.count
            print(CELL_COUNT)
        })
    }
    
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print("Login failed: \(error)")
            case .cancelled:
                print("Login cancelled")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                print("Granted Permissions: \(grantedPermissions)")
                print("Declined Permissions: \(declinedPermissions)")
                print("Access Token: \(accessToken)")
                
                self.getProfileInfo()
            }
        }
    }
    
    func getProfileInfo() {
        let connection = GraphRequestConnection()
        let userID = AccessToken.current?.userId
        print(userID!)
        connection.add(GraphRequest(graphPath: "me", parameters: ["fields": "name, picture{url}"], accessToken: AccessToken.current!, httpMethod: .GET, apiVersion: .defaultVersion)){ httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                
                facebookName = response.dictionaryValue!["name"] as! String
                facebookUserID = response.dictionaryValue!["id"] as! String
                
                print("\(facebookName)-\(userID)")
                self.present(ViewController(), animated: true, completion: nil)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //if let accessToken = AccessToken.current {
        //    // User is logged in
        //    print("Already logged in")
        //    self.present(TableViewController(), animated: false, completion: nil)
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

