//
//  ViewController.swift
//  Homework5_RMC
//
//  Created by Raúl Mora-Colón on 4/13/18.
//  Copyright © 2018 Raúl Mora-Colón. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var redColorViewModels = [ColorViewModel]()
    var colorViewModels = [[ColorViewModel]]()

    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
            segmentControl.setTitle("Reds", forSegmentAt: 0)
            segmentControl.setTitle("Blues", forSegmentAt: 1)
            segmentControl.setTitle("Random", forSegmentAt: 2)
            segmentControl.tintColor = .black
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tintColor = .white
            tableView.layer.cornerRadius = 5.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Table"
        
        colorViewModels.append(ColorManager.generateColors(desired: 100, red: true, green: false, blue: false))
        colorViewModels.append(ColorManager.generateColors(desired: 100, red: false, green: false, blue: true))
        colorViewModels.append(ColorManager.generateColors(desired: 100, red: true, green: true, blue: true))
        
        tableView.reloadData()
    }

    @objc private func segmentControlValueChanged() {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var colorViewModel = colorViewModels[segmentControl.selectedSegmentIndex][indexPath.row]
        colorViewModel.isSelected = !colorViewModel.isSelected
        colorViewModels[segmentControl.selectedSegmentIndex][indexPath.row] = colorViewModel
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorViewModels[segmentControl.selectedSegmentIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colorViewModel = colorViewModels[segmentControl.selectedSegmentIndex][indexPath.row]
        let cell = UITableViewCell()
        cell.backgroundColor = colorViewModel.color
        cell.selectionStyle = .none
        cell.textLabel?.text = colorViewModel.name
        cell.textLabel?.textColor = .white
        cell.accessoryType = colorViewModel.isSelected ? .checkmark : .none
        return cell
    }
}
