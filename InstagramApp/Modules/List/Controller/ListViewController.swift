//
//  ListViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 29/08/2023.
//

import UIKit

class ListViewController: UIViewController {

    //MARK: - UI
    private let tablView: UITableView = {
        let tableview = UITableView()
        tableview.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return tableview
    }()
    
    
   // private let data: [String]?
    private var data = [UserRelationship]()

    //MARK: - Init
    init(data: [UserRelationship]){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureTableView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tablView.frame = view.bounds
    }
    
    //MARK: - Private Func
    private func configureTableView() {
        
        tablView.delegate = self
        tablView.dataSource = self
        view.addSubview(tablView)
    }

}
//MARK: - UITableView Delegate & DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
      //  return dataa.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell

        let model = data[indexPath.row]
      cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //go to profile of selected cell
        let model = data[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

//MARK: - UserFollowTableViewCellDelegate
extension ListViewController: UserFollowTableViewCellDelegate{
    
    func didTapFollowUnfollowButton(model: UserRelationship) {
        
        switch model.type {
        case .following:
          // perform firebase update to unfollow
            break
        case .not_following:
            // perform firebase update to follow
           break
        }
    }
  
}
