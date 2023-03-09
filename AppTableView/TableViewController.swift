//
//  TableViewController.swift
//  AppTableView
//
//  Created by Nasim Nozirov on 18.02.2023.
//

import UIKit

class TableViewController: UITableViewController {

    private var dataCar = ["MERCEDES", "BMW", "FERRARI", "JAGUAR", "MAZDA", "MUSTANG", "TESLA", "VOLKSWAGEN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 145
        createEditingButton()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCar.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:  UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        var configuration = cell.defaultContentConfiguration()
        let car = dataCar[indexPath.row]
        configuration.text = car
        configuration.image = UIImage(named: car)
        configuration.textProperties.alignment = .natural
        configuration.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = configuration

        return cell
    }
    
    //УДАЛЯЕМ ЯЧЕЙКИ
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { _,_,_ in
            self.dataCar.remove(at: indexPath.row)
            tableView.reloadData()
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // без этого кнопки не видно будет
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    //МЕНЯЕМ МЕСТАМИ ЯЧЕЙКИ
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObject = self.dataCar[sourceIndexPath.row]  // ОТСЮДА БЕРЕМ СТРОКУ
        dataCar.remove(at: sourceIndexPath.row)  // СДЕСЬ УДАЛЯЕМ
        dataCar.insert(moveObject, at: destinationIndexPath.row)  // А СДЕСЬ ДОБАВЛЯЕМ И ТАК МИ ПОМЕНЯЛИ МЕСТАМИ :)
    }
    
    // СОЗДАЕМ КНОПКУ и прикручиваем
    private func createEditingButton() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(beginEditing))
        navigationItem.rightBarButtonItem = editButton
    }

    // меняем кнопку и делаем его изменяемий, что соверщать какие-то действие
    @objc private func beginEditing() {
        tableView.isEditing = true
        let endButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        navigationItem.rightBarButtonItem = endButton
    }
    
    @objc private func endEditing() {
        tableView.isEditing = false
        createEditingButton()
    }
   
}
