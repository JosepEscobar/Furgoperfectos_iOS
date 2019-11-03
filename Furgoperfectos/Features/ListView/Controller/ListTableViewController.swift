//
//  ListTableViewController.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import Kingfisher

class ListTableViewController: UITableViewController {
    
    var listViewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        listViewModel.fetchData(success: {
            self.tableView.reloadData()
        }, networkFailure: { (error) in
            
        }, serverFailure: { (error) in
            
        }, businessFailure: { (error) in
            
        }) { (error) in
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.numberOfFurgoperfectos
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listReuseIdentifier", for: indexPath) as? ListTableViewCell {
            // Configure the cell...
            let title = listViewModel.getName(index: indexPath.row)
            let description = listViewModel.getDescription(index: indexPath.row)
            let imageURL = listViewModel.getImage(index: indexPath.row)
            cell.configureCell(title: title, description: description, imageURL: imageURL)
            
            return cell
        } else {
            return UITableViewCell()
        }

        

        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
