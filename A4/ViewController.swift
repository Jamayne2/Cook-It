//
//  ViewController.swift


import UIKit

class ViewController: UIViewController{

    private var recipeCollectionview : UICollectionView!
    private var filterCollectionView : UICollectionView!
    
    private var filters : [String] = ["All", "Beginner", "Intermediate", "Advanced"]
    private var selectedFilterIndex = 0
    private var SelectedAll : Bool = false
    private var SelectedB : Bool = false
    private var SelectedI : Bool = false
    private var SelectedA : Bool = false
    private let refresh = UIRefreshControl()
    
    
    private var filteredRecipes : [Recipe] = []
    private var AllRecipes : [Recipe] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Cook It!"
        setupCollectionView2()
        setupCollectionView1()
        fetchRecipes()
       
    }

     // MARK : Networking
    @objc private func fetchRecipes(){
        NetworkManager.shared.fetchRecipes { [weak self] AllRecipes in
            guard let self = self else { return }
            self.AllRecipes = AllRecipes
            
            DispatchQueue.main.async{
                self.recipeCollectionview.reloadData()
                self.refresh.endRefreshing()
            }
        }

        
    }
    
    
    private func applyFilter() {
        let selectedFilter = filters[selectedFilterIndex]
        
        // Use the filter higher order function to filter recipes
        filteredRecipes = AllRecipes.filter { recipe in
            switch selectedFilter {
                    case "All":
                        SelectedB = false
                        SelectedA = false
                        SelectedI = false
                        SelectedAll = true // Show all recipes, so set Selected to false
                        return true
                    case "Beginner":
                        // Set Selected to true only for "YourSpecificFilter"
                        
                        SelectedA = false
                        SelectedI = false
                        SelectedAll = false
                        SelectedB = true
                        return recipe.difficulty == selectedFilter
                    
                    case "Advanced":
                        
                        SelectedI = false
                        SelectedAll = false
                        SelectedB = false
                        SelectedA = true
                        return recipe.difficulty == selectedFilter
                    
                    case "Intermediate":
                        SelectedA = false
                        SelectedAll = false
                        SelectedB = false
                        SelectedI = true
                        return recipe.difficulty == selectedFilter
                
                    default:
                         // For all other filters, set Selected to false
                        return true
                    }
            
            // Reload recipe collection view to update displayed recipes
            
        }
        
        recipeCollectionview.reloadData()
        
    }
   
    private func setupCollectionView1(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        
        
        recipeCollectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        recipeCollectionview.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        recipeCollectionview.delegate = self
        recipeCollectionview.dataSource = self
        
        refresh.addTarget(self, action: #selector(fetchRecipes), for : .valueChanged)
        
        recipeCollectionview.refreshControl = refresh
        
        view.addSubview(recipeCollectionview)
        recipeCollectionview.translatesAutoresizingMaskIntoConstraints = false
        recipeCollectionview.alwaysBounceVertical = true
        
        
        NSLayoutConstraint.activate([
            recipeCollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeCollectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeCollectionview.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 32),
            recipeCollectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupCollectionView2(){
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout2.scrollDirection = .horizontal
        flowLayout2.minimumLineSpacing = 16
//        flowLayout2.minimumInteritemSpacing = 16
        
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout2)
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuse)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        view.addSubview(filterCollectionView)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.alwaysBounceVertical = true
        
        NSLayoutConstraint.activate([
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 24)
            
        ])
        
    }

}

extension ViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == recipeCollectionview){
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as? RecipeCollectionViewCell{
                let recipe = filteredRecipes[indexPath.row]
                cell.configure(recipe: recipe)
                return cell
            }
        }
        else if collectionView == filterCollectionView {
            if let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuse, for: indexPath) as? FilterCollectionViewCell{
                let filter = filters[indexPath.row]
                cell2.configure(filter: filter, isSelectedAll: SelectedAll, isSelectedB: SelectedB, isSelectedA: SelectedA, isSelectedI: SelectedI)
                return cell2
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == recipeCollectionview){
            return filteredRecipes.count//(This should be recipe.count)
        }
        return filters.count
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == recipeCollectionview){
            print("Selected item at index: \(indexPath.item)")
            var selectedItem = filteredRecipes[indexPath.item]
            
            let recipeVC = RecipeView(imageurl: selectedItem.imageUrl, description: selectedItem.description, name: selectedItem.name)
            recipeCollectionview.reloadData()
            // Pass the selected item to the destination view controller
            recipeVC.delegate = self
            
            navigationController?.pushViewController(recipeVC, animated: true)
            
            
            
            

        }
        
        else{
            selectedFilterIndex = indexPath.item
            applyFilter()
            filterCollectionView.reloadData()
            }
        
    }
}
    

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recipeCollectionview{
            let size = collectionView.frame.width/2 - 16
            return CGSize(width: size, height: size)
        }
        return CGSize(width: 120, height: 24)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      if collectionView == recipeCollectionview{
          return 32 // Adjust the interitem spacing as needed
       }
       return 32
           
  }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 40 // Adjust the line spacing as needed
 }
    
}





extension Recipe {
 
    static let dummyData = [
        Recipe(
            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
            description: "This ropa vieja is great served on tortillas or over rice. Add sour cream, cheese, and fresh cilantro on the side.",
            difficulty: "Intermediate",
            imageUrl: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8368708.jpg&q=60&c=sc&orient=true&poi=auto&h=512",
            name: "Cuban Ropa Vieja",
            rating: 4.4
        ),
        Recipe(
            id: "9d40a3f8-a40f-48c0-9aa6-28031fddde81",
            description: "You only need 3 ingredients for this crockpot Italian chicken with Italian dressing and Parmesan cheese. Nothing could be easier than this for a weekday meal that's ready when you get home.",
            difficulty: "Beginner",
            imageUrl: "https://www.allrecipes.com/thmb/cLLmeWO7j9YYI66vL3eZzUL_NKQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7501402crockpot-italian-chicken-recipe-fabeveryday4x3-223051c7188841cb8fd7189958c62f3d.jpg",
            name: "Crockpot Italian Chicken",
            rating: 4.5
        ),
        Recipe(
            id: "0c28ab59-e99d-4ec1-be2f-359a92537560",
            description: "This crockpot mac and cheese recipe is creamy, comforting, and takes just moments to assemble in a slow cooker. Great for large family gatherings and to take to potluck dinners. It's always a big hit!",
            difficulty: "Beginner",
            imageUrl: "https://www.allrecipes.com/thmb/wRSDpUgu8VR2PpQtjGq97cuk8Fo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/237311-slow-cooker-mac-and-cheese-DDMFS-4x3-9b4a15f2c3344c1da22b034bc3b35683.jpg",
            name: "Slow Cooker Mac and Cheese",
            rating: 4.3
        ),
        Recipe(
            id: "ef10e605-65d0-4a85-9fd8-8e3294939473",
            description: "My mother was one of the best cooks I ever knew. Whenever she made stews we mostly found homemade dumplings in them. We never ate things from packages or microwaves and you sure could taste what food was. That's the only way I cook today - I don't use any electronic gadgets to cook with except an electric stove.",
            difficulty: "Beginner",
            imageUrl: "https://www.allrecipes.com/thmb/neJT4JLJz7ks8D0Rkvzf8fRufWY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/6900-dumplings-DDMFS-4x3-c03fe714205d4f24bd74b99768142864.jpg",
            name: "Homemade Dumplings",
            rating: 4.7
        ),
        Recipe(
            id: "a69bdffc-c9ba-428b-8f06-24cef356a611",
            description: "Succulent pork loin with fragrant garlic, rosemary, and wine.",
            difficulty: "Advanced",
            imageUrl: "https://www.allrecipes.com/thmb/llWmU-j1PO7kCPvKkzQnfmeBf0M=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/21766-roasted-pork-loin-DDMFS-4x3-42648a2d6acf4ef3a05124ef5010c4fb.jpg",
            name: "Roasted Pork Loin",
            rating: 4.5
        ),
        Recipe(
            id: "85745755-11dd-4e68-8953-15f5194971bc",
            description: "My version of chicken Parmesan is a little different than what they do in the restaurants, with less sauce and a crispier crust.",
            difficulty: "Intermediate",
            imageUrl: "https://www.allrecipes.com/thmb/0NW5WeQpXaotyZHJnK1e1mFWcCk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/223042-Chicken-Parmesan-mfs_001-7ab952346edc4b2da36f3c0259b78543.jpg",
            name: "Chicken Parmesan",
            rating: 4.8
        )
    ]
 
}

extension ViewController: RecipeViewDelegate{
   
        
        func reloadData() {
             recipeCollectionview.reloadData()
            
        }

  
    }
        



