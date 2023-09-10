//
//  SettingsViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 26/08/2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Outlets
    let tableView : UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableview
    }()
    //MARK: - Private Variables
    private var data = [[SettingCellModel]]() //cuz we will have multible sections

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureModels()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignFramesToUI()
    }
  

    // MARK: - Private Functions
    
    private func setUpUI(){
        view.backgroundColor = .systemBackground
        addSubbViews()
    }
    private func addSubbViews(){
        view.addSubview(tableView)
        
    }
    
    private func assignFramesToUI(){
        tableView.frame = view.bounds
    }
  
    private func configureModels(){
        let section1 = [SettingCellModel(title: "Edit Profile") {
            ConfigureSettings.shared.didTapEditProfile(self)
            
        },SettingCellModel(title: "Invite Friends") {
            ConfigureSettings.shared.didTapInviteFriends()
           
        },SettingCellModel(title: "Save Original Posts") {
            ConfigureSettings.shared.didTapSaveOriginalPosts()
            
        }
             
        ]
        data.append(section1)
        let section2 = [SettingCellModel(title: "Terms of Services") {
            ConfigureSettings.shared.openURL(type: .terms, self)
            
        },SettingCellModel(title: "Privacy Policy") {
            ConfigureSettings.shared.openURL(type: .privacy, self)
           
        },SettingCellModel(title: "Help / Feedback") {
            ConfigureSettings.shared.openURL(type: .help, self)
            
        }
                       ]
        data.append(section2)
        let section3 = [SettingCellModel(title: "Log Out") {
            [weak self] in
            self?.didTapLogOut()
        }
                       ]
        
        data.append(section3)
        
    }
    
    private func didTapLogOut(){
        logOutAlert {
            ConfigureSettings.shared.logOut(self)
        }
    }
   
}

// MARK: - TableView DataSource , Delegate
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return configure(cell, where: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
    
}
// MARK: - Configure Cell
extension SettingsViewController {
    
    func configure(_ cell: UITableViewCell, where indexPath: IndexPath) -> UITableViewCell {
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = data[indexPath.section][indexPath.row].title
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        }
        
        return cell
    }
}
