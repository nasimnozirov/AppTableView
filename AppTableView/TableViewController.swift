//
//  TableViewController.swift
//  AppTableView
//
//  Created by Nasim Nozirov on 18.02.2023.
//

import UIKit

class TableViewController: UITableViewController {

   private let cars = ["MERCEDES", "BMW", "FERRARI", "JAGUAR", "MAZDA", "MUSTANG", "TESLA", "VOLKSWAGEN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 145
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:  UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        var configuration = cell.defaultContentConfiguration()
        let car = cars[indexPath.row]
        configuration.text = car
        configuration.image = UIImage(named: car)
        configuration.textProperties.alignment = .natural
        configuration.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = configuration

        return cell
    }


   
}
