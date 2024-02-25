//
//  RecipeCollectionViewCell.swift
//  A4
//
//  Created by Jamayne Gyimah-Danquah on 11/11/23.
//

import Foundation
import UIKit
import SDWebImage

class RecipeCollectionViewCell : UICollectionViewCell {
    
    private let recipeImage = UIImageView()
    private let recipeNameLabel = UILabel()
    private let recipeLevel = UILabel()
    private let recipeRating = UILabel()
    private let bookmarkicon = UIImageView()
    
    
    static let reuse = "RecipeCollectionViewCellReuse"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupRecipeImage()
        setupRecipeNameLabel()
        setupRecipeLevel()
        setupRecipeRating()
        setupbookmark()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(recipe : Recipe){
        recipeImage.sd_setImage(with: URL(string: recipe.imageUrl))
        recipeNameLabel.text = recipe.name
        recipeLevel.text = recipe.difficulty
        recipeRating.text = String(recipe.rating)
        var favorites = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
        bookmarkicon.image = (favorites.contains(recipe.name)) ? UIImage(systemName: "bookmark.fill") : nil
        
       
    }
    
    private func setupRecipeImage(){
        recipeImage.contentMode = .scaleToFill
        
        contentView.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.layer.cornerRadius = 32 / 2
        recipeImage.layer.masksToBounds = true
        recipeImage.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            recipeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            recipeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: 148),
            recipeImage.widthAnchor.constraint(equalToConstant: 148),
        ])
    }
    

    
    private func setupRecipeNameLabel(){
        recipeNameLabel.textColor = .label
        recipeNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(recipeNameLabel)
        recipeNameLabel.numberOfLines = 2
        
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeNameLabel.centerXAnchor.constraint(equalTo: recipeImage.centerXAnchor),
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 8),
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImage.leadingAnchor, constant: 0),
            recipeNameLabel.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 0)
        ])
        
    }
    
    private func setupRecipeLevel(){
        recipeLevel.textColor = .label
        recipeLevel.font = .systemFont(ofSize: 8, weight: .medium)
        contentView.addSubview(recipeLevel)
        
        recipeLevel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeLevel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeLevel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 4),
            recipeLevel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeLevel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
        ])
        
    }
    
    private func setupRecipeRating(){
        recipeRating.textColor = .label
        recipeRating.font = .systemFont(ofSize: 8, weight: .medium)
        contentView.addSubview(recipeRating)
        
        recipeRating.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeRating.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeRating.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 4),
            recipeRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            recipeRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
        ])
        
    }
    
    private func setupbookmark(){
        
        
        contentView.addSubview(bookmarkicon)
        
        bookmarkicon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookmarkicon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookmarkicon.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 4),
            bookmarkicon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 150),
            bookmarkicon.heightAnchor.constraint(equalToConstant: 16),
            bookmarkicon.widthAnchor.constraint(equalToConstant: 16)
        ])
        
    }
    
        
    }
    
        
 
        
    

