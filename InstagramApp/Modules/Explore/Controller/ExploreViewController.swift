//
//  ExploreViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.placeholder = "Search"
        searchbar.backgroundColor = .secondarySystemBackground
       return searchbar
    }()
    
    private var collectioView: UICollectionView?
    
    private var models = [UserPost]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        searchBar.delegate = self
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignFramesToUI()
    }


    // MARK: - Private Functions
    private func setUpUI(){
      
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        configureCollectionView()
    }

    private func assignFramesToUI(){
        collectioView?.frame = view.bounds
    }
    
    private func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)   //bading between sections
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        //square
        collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView?.delegate = self
        collectioView?.dataSource = self
        collectioView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        guard let collectioView else {
            return
        }
        view.addSubview(collectioView)
    }

}

// MARK: - CollectioView DataSource , Delegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
      //  cell.configure(with: <#T##UserPost#>)
        cell.configure(imageName: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       // let model = models[indexPath.row]
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
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - UISearchBarDelegate
extension ExploreViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        guard let text = searchBar.text , !text.isEmpty else {return}
     query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didCancelSearch))
    }
    
    private func query(_ text: String){
        // perform the search in the back end
        
    }
    @objc private func didCancelSearch(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
}
//MARK: - UISearchBarDelegate

