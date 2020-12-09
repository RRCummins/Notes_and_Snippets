//
//  ViewController.swift
//  SettingsExample
//
//  Created by Ryan Cummins on 12/9/20.
//

import UIKit

// Tutorial from --->>> https://www.youtube.com/watch?v=2FigkAlz1Bg

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var isOn: Bool
    let handler: (() -> Void)
}

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        models.append(Section(title: "Options", options: [
            .switchCell(model: SettingsSwitchOption(title: "Dark Mode", icon: UIImage(systemName: "sun.max"), iconBackgroundColor: .systemTeal, isOn: false) {
                // Set up a delegate for this handler to control things via switch
            })
        ]))
        
        models.append(Section(title: "General", options: [
            .staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemGray) {
                print("Tapped Wifi")
            }),
            .staticCell(model: SettingsOption(title: "BlueTooth", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .link) {
                print("Tapped a cell")
            }),
            .staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemOrange) {
                
            }),
            .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "icloud"), iconBackgroundColor: .systemBlue) {
                
            }),
        ]))
        
        models.append(Section(title: "Information", options: [
            .staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemGray) {
                
            }),
            .staticCell(model: SettingsOption(title: "BlueTooth", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .link) {
                
            }),
            .staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemRed) {
                
            }),
            .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "icloud"), iconBackgroundColor: .systemBlue) {
                
            }),
        ]))
        
        models.append(Section(title: "Apps", options: [
            .staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemGray) {
                
            }),
            .staticCell(model: SettingsOption(title: "BlueTooth", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .link) {
                
            }),
            .staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemRed) {
                
            }),
            .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "icloud"), iconBackgroundColor: .systemBlue) {
                
            }),
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingsTableViewCell.identifier,
                    for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SwitchTableViewCell.identifier,
                    for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
}

