//
//  TableViewController.swift
//  AppTableView
//
//  Created by Nasim Nozirov on 18.02.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var dataCar = ["MERCEDES", "BMW", "FERRARI", "JAGUAR", "MAZDA", "MUSTANG", "TESLA", "VOLKSWAGEN"]
    
    private var imageDict: [String: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 145
        createAddButton()
        createEditingButton()
        prepareImageDict()
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
        if let image = imageDict[car.uppercased()] {
            configuration.image = image
        }
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
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { _,_,_ in
            self.showAlert(title: "Edit name", indexPath: indexPath)
            tableView.reloadData()
        })
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    //дополнительная функция удалене итд с левой части экрана появляется
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    // чтобы ячейки не сдивигались
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //МЕНЯЕМ МЕСТАМИ ЯЧЕЙКИ местами
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObject = self.dataCar[sourceIndexPath.row]  // ОТСЮДА БЕРЕМ СТРОКУ
        dataCar.remove(at: sourceIndexPath.row)  // СДЕСЬ УДАЛЯЕМ
        dataCar.insert(moveObject, at: destinationIndexPath.row)  // А СДЕСЬ ДОБАВЛЯЕМ И ТАК МИ ПОМЕНЯЛИ МЕСТАМИ :)
    }
    
    private func prepareImageDict() {
        for item in 0..<dataCar.count {
            let key = dataCar[item]
            let value = UIImage(named: key)
            imageDict[key] = value
        }
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
    
    private func createAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(editing))
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc private func editing() {
        showAlert(title: "Add new car")
    }
    
    @objc private func end() {
        createAddButton()
    }
}

extension TableViewController {
    private func showAlert(title: String) {
       
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let carName = alert.textFields?.first?.text else { return }
            self.dataCar.append(carName)
            self.tableView.reloadData()
          
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textField in
            textField.placeholder = "Text"
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, indexPath: IndexPath) {
       
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let carName = alert.textFields?.first?.text else { return }
            self.dataCar[indexPath.row] = carName
            self.tableView.reloadData()
          
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textField in
            textField.placeholder = "Text"
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
