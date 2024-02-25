//
//  FilterCollectionViewCell.swift
// 
//

import Foundation
import Foundation
import UIKit
import SDWebImage

class FilterCollectionViewCell : UICollectionViewCell {
    
    private let filterButton = UILabel()


    
    static let reuse = "FilterCollectionViewCellReuse"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupfilterButton()

        contentView.layer.cornerRadius = 24 / 2
        

    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    func configure(filter: String, isSelectedAll : Bool, isSelectedB : Bool, isSelectedA : Bool, isSelectedI : Bool){
        filterButton.textColor = .black
        filterButton.textAlignment = .center
        filterButton.font = .systemFont(ofSize: 12)
        filterButton.text = filter
        
        if filter == "Beginner"{
            contentView.backgroundColor = (filter == "Beginner" && isSelectedB) ? .yellow : UIColor.a4.offWhite
            
        } else if filter == "Intermediate"{
            contentView.backgroundColor = (filter == "Intermediate" && isSelectedI) ? .yellow : UIColor.a4.offWhite
        }else if filter == "Advanced" {
            contentView.backgroundColor = (filter == "Advanced" && isSelectedA) ? .yellow : UIColor.a4.offWhite
        }else{
            contentView.backgroundColor = (filter == "All" && isSelectedAll) ? .yellow : UIColor.a4.offWhite
        }
        
        
        
        
        
    }
    
    private func setupfilterButton(){
        
        
        contentView.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.layer.masksToBounds = true
        filterButton.clipsToBounds = true
        
        
        NSLayoutConstraint.activate([
                    filterButton.topAnchor.constraint(equalTo: topAnchor),
                    filterButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                    filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                    filterButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                ])
    }
    

   
}
