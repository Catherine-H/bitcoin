//
//  ListeViewController.swift
//  ProjetBitcoin
//
//  Created by étudiant on 22/01/2019.
//  Copyright © 2019 bitcoin. All rights reserved.
//

import UIKit

class ListeViewController: UIViewController {

    var priceModels: [PriceModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    /*@IBOutlet weak var valeurlabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ListeViewController: UITableViewDelegate {
    
}

extension ListeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCellId", for: indexPath) as! DetailTableViewCell
        cell.fill(withPriceModel: priceModels[indexPath.row])
        return cell
        
    }
    
    
    
}
