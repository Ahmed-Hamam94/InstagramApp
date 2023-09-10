//
//  ProfileViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit
/// profile view controller
final class ProfileViewController: UIViewController {
    
    private var collectioView: UICollectionView? // its optional cuz i will instantiate it with flow layout
    
    private var userPosts = [UserPost]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignFramesToUI()
    }
    
    //MARK: - Private Functions
    
    private func setUpUI(){
        title = "Profile"
        view.backgroundColor = .systemBackground
        tabBarItem.title = .none
        
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func assignFramesToUI(){
        collectioView?.frame = view.bounds
    }
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTabSettingsButton))
    }
    private func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)   //bading between sections
        let size = (view.width-4)/3
        layout.itemSize = CGSize(width: size, height: size) //square
        collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        //cell
        collectioView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        //Headers
        collectioView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectioView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectioView?.delegate = self
        collectioView?.dataSource = self
        guard let collectioView else {
            return
        }
        view.addSubview(collectioView)
    }
    
    //MARK: - @objc Functions
    @objc private func didTabSettingsButton(){
        let vc =  SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
}
// MARK: - CollectioView DataSource , Delegate
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
       // return userPosts.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
      //  cell.configure(with: model)
        cell.configure(imageName: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // get the model and open post controller
        //let model = userPosts[indexPath.row]
        let user = User(username: "mo", bio: "", name: (firs: "", last: ""), profileImage: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        
            let post = UserPost(identifier: "",
                                postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!,
                                postUrl: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [], owner: user)
        
        
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
       
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            // foter
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            //tabs header
            
            let tabsHeader  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            tabsHeader.delegate = self
            return tabsHeader
        }
        let profileHeader  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        
        profileHeader.delegate = self
        
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
        //size of section tabs
        return CGSize(width: collectionView.width, height: 50)
    }
}
//MARK: - ProfileInfoHeaderDelegate
extension ProfileViewController: ProfileInfoHeaderDelegate {
     
    func profileHeaderDidTabPostsBtn(_ header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to posts
        collectioView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTabFollowerBtn(_ header: ProfileInfoHeaderCollectionReusableView) {
        
        var mockData = [UserRelationship]()
        for counter in 0..<10 {
            mockData.append(UserRelationship(name: "Ahmed", username: "@ahmed", type: counter % 2 == 0 ? .following : .not_following))
        }
        
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTabFollowingBtn(_ header: ProfileInfoHeaderCollectionReusableView) {
        
        var mockData = [UserRelationship]()
        for counter in 0..<10 {
            mockData.append(UserRelationship(name: "Ahmed", username: "@ahmed", type: counter % 2 == 0 ? .following : .not_following))
        }
        
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTabEditBtn(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
       
    }
    
    
}
//MARK: - ProfileTabsDelegate
extension ProfileViewController: ProfileTabsDelegate {
    
    func didTapGridButtonTab() {
        // reload collectioview with data
    }
    
    func didTapTaggedButtonTab() {
        // reload collectioview with data
    }
    
 
    
    
}
