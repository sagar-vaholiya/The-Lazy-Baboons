//
//  ComplaintListController.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 20/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import UIKit

class ComplaintListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Complaint List"
    }
    
    @IBAction func performLogout(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true) {
            defaults.removeObject(forKey: "userObject")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension ComplainListController : UITableViewDelegate, UITableViewDataSource {

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return <#count#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! <#cellclass#>
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
//}


class ComplainCell : UITableViewCell {
    
    override func awakeFromNib() {
        
    }
    
    func configure() {
        
    }
    
    
}
