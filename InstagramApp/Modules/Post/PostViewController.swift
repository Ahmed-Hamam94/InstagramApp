//
//  PostViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 29/08/2023.
//

import UIKit

class PostViewController: UIViewController {
    
    //MARK: - UI
    private let tableView: UITableView = {
       let tableview = UITableView()
        return tableview
    }()
    
    //MARK: - Private Variables
    private let model: UserPost?
    private var renderModels = [PostRenderModel]()
    
    //MARK: - Initializer
    init(model: UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Section
     - Header Model
     Section
     - Post cell Model
     Section
     - Action Buttons cell model
     Section
     - n number of cell models for comments
     */
    
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

 
    // MARK: - Private Functions
    private func setUpUI(){
        configureTableView()
    }
    private func configureTableView(){
        view.addSubview(tableView)
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
    
    private func configureModels(){
        guard let userPostModel = self.model else {return}
        // header
        renderModels.append(PostRenderModel(renderType: .header(provider: userPostModel.owner)))
        // post
        renderModels.append(PostRenderModel(renderType: .primaryContent(provider: userPostModel)))
        // actions
         renderModels.append(PostRenderModel(renderType: .actions(provider: "")))
        //comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@mo", text: "great post", createdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderModel(renderType: .comments(comments: comments)))
    }

}
// MARK: - UITableView Delegate & DataSource
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch renderModels[section].renderType {
            
        case .header(_):
            return 1
        case .primaryContent(_):
            return 1
        case .actions(_):
            return 1
        case .comments(let comments):
           return comments.count > 4 ? 4 : comments.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section] // cuz section has the type will return
        switch model.renderType {
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifieer, for: indexPath) as! FeedPostHeaderTableViewCell
            
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifieer, for: indexPath) as! FeedPostTableViewCell
            
            return cell
            
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifieer, for: indexPath) as! FeedPostActionsTableViewCell
            
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifieer, for: indexPath) as! FeedPostGeneralTableViewCell
            
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch renderModels[indexPath.section].renderType {
            
        case .header(_):
            return 70
        case .primaryContent(_):
            return tableView.width
        case .actions(_):
            return 60
        case .comments(_):
           return 50
        }
    }
    
}
