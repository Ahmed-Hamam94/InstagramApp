//
//  NotificationsViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit

class NotificationsViewController: UIViewController {

    private var tableView: UITableView = {
       let tableview = UITableView()
        tableview.isHidden = false
        tableview.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableview.register(NotificationsFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationsFollowEventTableViewCell.identifier)
        return tableview
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationView = NoNotificationsView()
    
    private var models = [UserNottification]()

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignFramesToUI()
    }

    
    // MARK: - Private Functions
    private func setUpUI(){
        title = "Notifications"
        view.backgroundColor = .systemBackground
        tabBarItem.title = .none
        fetchNotifications()
        configureSpinner()
        configureTableView()
       
        
       
    }
    
    private func configureSpinner(){
        view.addSubview(spinner)
     //   spinner.startAnimating()
       
       // view.addSubview(noNotificationView)
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
   

    private func assignFramesToUI(){
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
       // addNoNotificationsView()
        
    }
    
    private func addNoNotificationsView(){
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationView.center = view.center
    }
    
    private func fetchNotifications(){
        let user = User(username: "mo", bio: "", name: (firs: "", last: ""), profileImage: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        
        for x in 0...100{
            let post = UserPost(identifier: "",
                                postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!,
                                postUrl: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [], owner: user)
            
            let model = UserNottification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                          text: "Hello World",
                                          user: user)
            models.append(model)
        }
    }

}

// MARK: - TableView DataSource , Delegate
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let model = models[indexPath.row]
        
        switch model.type {
            
        case .like(_):
            //like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            //follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsFollowEventTableViewCell.identifier, for: indexPath) as! NotificationsFollowEventTableViewCell
       //   cell.configure(with: model)
          cell.delegate = self
            return cell
        }

    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
//MARK: - NotificationLikeEventDelegate & NotificationsFollowEventDelegate
extension NotificationsViewController: NotificationLikeEventDelegate, NotificationsFollowEventDelegate {
   
    func didTapRelatedButton(model: UserNottification) {
       
        //open the post
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .follow(state: _):
            fatalError("error")
        }
    }
    
    func didTapFollowUnfollowButton(model: UserNottification) {
        print("tapped button")
        //perform database update
    }
}
