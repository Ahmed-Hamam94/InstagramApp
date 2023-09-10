//
//  HomeViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    private var tableView: UITableView = {
        let tableview = UITableView()
        
        return tableview
    }()
    
    private var feedRenderModels = [HomeFeedRenderModel]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        setUpUI()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuth()
        //        do {
        //            try Auth.auth().signOut()
        //        }catch {
        //            print("er")
        //        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private Functions
    
    private func checkAuth(){
        if Auth.auth().currentUser == nil {
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: false)
        }
    }
    private func setUpUI(){
        title = "Home"
        tabBarItem.title = .none
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureTableView()
        
    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    private func registerCell(){
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifieer)
        tableView.register(FeedPostActionsTableViewCell.self, forCellReuseIdentifier: FeedPostActionsTableViewCell.identifieer)
        tableView.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifieer)
        tableView.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifieer)
    }
    
    private func createMockModels(){
        
        let user = User(username: "@ahmed_hamam", bio: "", name: (firs: "", last: ""), profileImage: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        
        for x in 0...6{
            let post = UserPost(identifier: "",
                                postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!,
                                postUrl: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [], owner: user)
            var comments = [PostComment]()
            for x in 0...2 {
                comments.append(PostComment(identifier: "\(x)", username: "@sera", text: "nice pic", createdDate: Date(), likes: []))
            }
            
            for x in 0..<5 {
                let viewModel = HomeFeedRenderModel(header: PostRenderModel(renderType: .header(provider: user)),
                                                    
                                                    post: PostRenderModel(renderType: .primaryContent(provider: post)),
                                                    
                                                    actions: PostRenderModel(renderType: .actions(provider: "")),
                                                    
                                                    comments: PostRenderModel(renderType: .comments(comments: comments)))
                
                feedRenderModels.append(viewModel)
                
            }
        }
            
        }
    
    
   
    }




    // MARK: - UITableView Delegate & DataSource
 extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            
            return feedRenderModels.count * 4 // each model has 4 sections
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let x = section
            let model: HomeFeedRenderModel
            if x == 0 {
                model = feedRenderModels[0]
            }else{
                let position = x % 4 == 0 ? x/4 : ((x - (x%4))/4)
                model = feedRenderModels[position]
                
            }
            let subSection = x % 4
            if subSection == 0 {
                // header
                return 1
            }else if subSection == 1 {
                // post
                return 1
            }else if subSection == 2{
                // actions
                return 1
            }else if subSection == 3{
                // comments
                let commentsModel = model.comments
                switch commentsModel.renderType {
                case .comments(comments: let comments):
                    return comments.count > 2 ? 2 : comments.count
                case .header, .primaryContent, .actions: return 0
                    
                }
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let x = indexPath.section
            let model: HomeFeedRenderModel
            if x == 0 {
                model = feedRenderModels[0]
            }else{
                let position = x % 4 == 0 ? x/4 : ((x - (x%4))/4)
                model = feedRenderModels[position]
                
            }
            let subSection = x % 4
            if subSection == 0 {
                // header
                let headerModel = model.header
                switch headerModel.renderType {
                case .header(let user):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifieer, for: indexPath) as! FeedPostHeaderTableViewCell
                    cell.configure(with: user)
                    cell.delegate = self
                    return cell
                case .comments, .primaryContent, .actions: return UITableViewCell()
                }
                
            }else if subSection == 1 {
                // post
                let postModel = model.post
                switch postModel.renderType {
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifieer, for: indexPath) as! FeedPostTableViewCell
                    cell.configure(with: post)
                    return cell
                case .comments, .header, .actions: return UITableViewCell()
                }
                
            }else if subSection == 2{
                // actions
                let actionsModel = model.actions
                switch actionsModel.renderType {
                case .actions(let actions):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifieer, for: indexPath) as! FeedPostActionsTableViewCell
                    cell.delegate = self
                    return cell
                case .comments, .primaryContent, .header: return UITableViewCell()
                }
                
            }else if subSection == 3{
                // comments
                let commentsModel = model.comments
                switch commentsModel.renderType {
                case .comments(let comments):
                    let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifieer, for: indexPath) as! FeedPostGeneralTableViewCell
                    
                    return cell
                case .header, .primaryContent, .actions: return UITableViewCell()
                }
            }
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            let subSection = indexPath.section % 4
            if subSection == 0 {
                return 70
            }else if subSection == 1 {
                return tableView.width
            }else if subSection == 2 {
                return 60
            }else if subSection == 3 {
                return 50
            }
            return 0
        }
     
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         return UIView()
     }
     
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         let subSection = section % 4
        //space after post ..
         return subSection == 3 ? 70 : 0
     }
        
    }

//MARK: - FeedPostHeaderTableViewCellDelegate
extension HomeViewController: FeedPostHeaderTableViewCellDelegate{
    
    func didTapMoreButton() {
        actionSheet(title: "Post Options",actionTitle: "Report Post") { [weak self]  in
            self?.reportPost()
        }
                 
    }
    
    func reportPost(){
        print("report")
    }
    
    
}
//MARK: - FeedPostActionsTableViewCell
extension HomeViewController: FeedPostActionsTableViewCellDelegate {
    
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
    
}
