//
//  EditProfileViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit

final class EditProfileViewController: UIViewController {

    //MARK: - UI
    private let tableView : UITableView = {
       let tableview = UITableView()
        tableview.register(EditProfileFormTableViewCell.self, forCellReuseIdentifier: EditProfileFormTableViewCell.identifier)
        
        return tableview
    }()
    //MARK: - Private variables
    private var editProfileModel = [[EditProfileForm]]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Private Functions
    private func setUpUI(){
        setBarButtons()
        configureTableView()
        configureModel()
    }
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setBarButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    private func createTableHeaderView()-> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/3
        let profilePicButton = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePicButton)
        profilePicButton.layer.masksToBounds = true
        profilePicButton.layer.cornerRadius = size/2.0
        profilePicButton.tintColor = .label
        profilePicButton.addTarget(self, action: #selector(didTapProfilePicButton), for: .touchUpInside)
        profilePicButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePicButton.layer.borderWidth = 1
        profilePicButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    private func configureModel(){
        // first section will have 4 fields
        // name , username, website, bio
        let section1Labels = ["Name", "Username", "Website", "Bio"]
        var section1 = [EditProfileForm]()
        for label in section1Labels {
            let model = EditProfileForm(label: label, placeHolder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        editProfileModel.append(section1)
        //email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileForm]()
        for label in section2Labels {
            let model = EditProfileForm(label: label, placeHolder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        editProfileModel.append(section2)
    }

    //MARK: - @objc Private Functions
    @objc private func didTapSave() {
        
    }

    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapChangeProfilePic() {
        
    }
    @objc private func didTapProfilePicButton(){
        
    }
}
//MARK: - UITableView Delegate & DataSource

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return editProfileModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editProfileModel[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileFormTableViewCell.identifier, for: indexPath) as! EditProfileFormTableViewCell
        
        let model = editProfileModel[indexPath.section][indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {return nil}
        
        return "Private Information"
    }
}

//MARK: - Delegate
extension EditProfileViewController: EditProfileFormDelegate{
    
    func formTableViewCell(_ cell: EditProfileFormTableViewCell, didUpdateField updatedModel: EditProfileForm?) {
        //update the model
        print(updatedModel?.value ?? "")
    }
    
    
   
    
    
}
