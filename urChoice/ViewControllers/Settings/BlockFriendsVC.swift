//
//  BlockFriendsVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-09.
//

import UIKit

class BlockFriendsVC: BaseViewController {

    @IBOutlet weak var tbvu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVu()
        tbvu.delegate = self
        tbvu.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func setupVu(){
        tbvu.register(UINib(nibName: "BlockFriendsTVC", bundle: nil), forCellReuseIdentifier: "BlockFriendsTVC")
    }
    
    
    
    @IBAction func backBtnTpd(_ sender: Any) {
    }
    
}

extension BlockFriendsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockFriendsTVC", for: indexPath) as! BlockFriendsTVC
      
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
    }
}
