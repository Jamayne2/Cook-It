//
//  RecipeView.swift
//  Created by Jamayne Gyimah-Danquah on 11/11/23.
//

import Foundation
import UIKit
import SDWebImage

//
protocol RecipeViewDelegate: AnyObject {
    
        func reloadData()


}

class RecipeView: UIViewController {
    
    
    weak var delegate: RecipeViewDelegate?
  
    
    private let RecipeImage = UIImageView()
    private let RecipeName = UILabel()
    private let RecipeDescription = UILabel()
    private var isbookmarked : Bool = false
    private var bookmarkButton : UIBarButtonItem!
    var imageu : String
    var desc : String
    var namenne : String
    
    var favorites = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
 
    
    
    // MARK: - Properties (view)
    
    // MARK: - Properties (data)
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let backButton = UIBarButtonItem(title: "Chef OS", style: .plain, target: self, action: #selector(backButtonPressed))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
       
        //Set the title of the view controller
        setupRecipeImage()
        setupBookmarkButton()
        setupRecipeName()
        setupRecipeDescription()
    
    }
    
    @objc func backButtonPressed() {
            
           navigationController?.popViewController(animated: true)
           delegate?.reloadData()
        
       }
    
    init(imageurl : String, description:String, name:String){
        
        imageu = imageurl
        desc = description
        namenne = name
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBookmarkButton() {
        var bookmarkButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(toggleBookmark))
            
            // Load initial state from UserDefaults
            if let favorites = UserDefaults.standard.array(forKey: "bookmarked") as? [String], favorites.contains(namenne) {
                bookmarkButton.image = UIImage(systemName: "bookmark.fill")
            } else {
                bookmarkButton.image = UIImage(systemName: "bookmark")
            }
        

        navigationItem.rightBarButtonItem = bookmarkButton
        
        
    }
    
    @objc private func toggleBookmark() {
        
        var favorites = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
        
        // Toggle Favorite
        if favorites.contains(namenne){
            // Name is already stored -> Remove It
            favorites.removeAll(){ name in
                return name == namenne
            }
        } else {
            // Name not stored -> Add it
            favorites.append(namenne)
            
        }
        
        //Update UserDefaults
        UserDefaults.standard.setValue(favorites, forKey: "bookmarked")
        
        // Update CollectionView
        
        
        print(favorites)
        navigationItem.rightBarButtonItem?.image = (favorites.contains(namenne)) ? UIImage(systemName: "bookmark.fill") :UIImage(systemName: "bookmark")
        
        
        
            
        }
    
    
    private func setupRecipeImage(){
        //Configure the View
        RecipeImage.sd_setImage(with: URL(string: imageu))
        
        view.addSubview(RecipeImage)
        RecipeImage.translatesAutoresizingMaskIntoConstraints = false
        RecipeImage.layer.cornerRadius = 32 / 2
        RecipeImage.layer.masksToBounds = true
        RecipeImage.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            RecipeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120 ),
            RecipeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            RecipeImage.heightAnchor.constraint(equalToConstant: 328),
            RecipeImage.widthAnchor.constraint(equalToConstant: 328),
        ])
    }
    private func setupRecipeName(){
        //Configure the View
        
        RecipeName.font = .systemFont(ofSize: 24, weight: .bold)
        RecipeName.textColor = UIColor.black
        RecipeName.text = namenne
        //Add View as Subview
        view.addSubview(RecipeName)
        RecipeName.translatesAutoresizingMaskIntoConstraints = false

        RecipeName.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            RecipeName.centerXAnchor.constraint(equalTo: RecipeImage.centerXAnchor),
            RecipeName.topAnchor.constraint(equalTo: RecipeImage.bottomAnchor, constant: 32),

        ])
    }
    
    private func setupRecipeDescription(){
        //Configure the View
        RecipeDescription.textColor = .gray
        RecipeDescription.font = .systemFont(ofSize: 12, weight: .medium)
        view.addSubview(RecipeDescription)
        RecipeDescription.text = desc
        RecipeDescription.numberOfLines = 10
        
        RecipeDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            RecipeDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            RecipeDescription.topAnchor.constraint(equalTo: RecipeName.bottomAnchor, constant: 16),
            RecipeDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    RecipeDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

        ])
    }
    
        
        
        //MARK: - Set Up Views
        
}
    
    
