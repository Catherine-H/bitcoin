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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Valeur du Bitcoin"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
        priceModels.sort { $0.currentDate! > $1.currentDate! }
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCellId", for: indexPath) as! DetailTableViewCell
        cell.fill(withPriceModel: priceModels[indexPath.row])
        return cell
        
    }
    
}
