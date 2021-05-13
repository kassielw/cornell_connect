//
//  ViewController.swift
//  HackChallenge_
//
//  Created by Janice Lee on 5/4/21.
//

import UIKit

protocol LocationDelegate: class {
    func getLocation() -> String
}
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LocationDelegate {
    func getLocation() -> String{
        return locationArray[index].name
        
    }
    
    let main_Icon = UIImageView()
    var locationArray: [Attraction] = []
    var displayedLocationsArray: [Attraction] = []
    var filterArray: [Filter] = []
    var locationCollectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    var filterTitleLabel: UILabel!
    var locationTitleLabel: UILabel!
    
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let padding: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        title = "CornellConnect"
        
        main_Icon.image = UIImage(named: "icon")
        main_Icon.contentMode = .scaleAspectFit
        main_Icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(main_Icon)
        
//        let RPCC = Location(locationName: "RPCC", category: "Food", address: "107 Jessup Rd, Ithaca, NY 14850", info: "The service center with Nasties. You can get your mail and really crappy dining food all in one place. Oh yeah and COVID testing.")
//        let Louies = Location(locationName: "Louies", category: "Food", address: "534 Thurston Ave, Ithaca, NY 14850", info: "Where drunk emotionally unstable students go at 3 AM in the morning to get their fries. ")
//        let Goldies = Location(locationName: "Goldies", category: "Food", address: "245 East Ave, Ithaca, NY 14850", info: "Where you can get a mean latte after your Chem Lab that you just failed.")
//        let Terrace = Location(locationName: "Terrace", category: "Food", address: "130 Statler Dr, Ithaca, NY 14850", info: "You'll spend all your BRB's here on the burrito bowls that aren't even that tasty and are way overpriced.")
//        let Helen_Newman = Location(locationName: "Helen Newman", category: "Fitness", address: "163 Cradit Farm Rd, Ithaca, NY 14850", info: "Let's get rIpPed TonIghT. RIP your stress for only 50 minutes at a time. Can also bowl here but bowling is kinda boring.")
//        let Trillium = Location(locationName: "Trillium", category: "Food", address: "215 Garden Ave, Ithaca, NY 14850", info: "Only been here twice but has bomb pasta and Chinese food. Food's bussin. SheeEEEsh.")
//        let Noyes = Location(locationName: "Noyes", category: "Fitness", address: "306 West Ave, Ithaca, NY 14850", info: "Noyes body you got there. Wanna work out sometime?")
//        let Teagle_Down = Location(locationName: "Teagle Down", category: "Fitness", address: "512 Campus Rd, Ithaca, NY 14850", info: "Too many ripped body builders here. Caution before going: may make you feel extremely insecure about your own body. RIP self confidence but still go. Gotta start somewhere.")
//        let Beebe_Lake_Trail = Location(locationName: "Beebe Lake Trail", category: "Fitness", address: "101 Forest Home Dr, Ithaca, NY 14850", info: "Mmm very pretty. Pew Pew!!")
//        let Cascadilla_Gorge_Trail = Location(locationName: "Cascadilla Gorge Trail", category: "Fitness", address: "Cascadilla Gorge Trail, Ithaca, NY 14850", info: "Get yo steps in. Nice waterfalls. The view is nice but you look nicer ;)")
//        let PSB = Location(locationName: "PSB", category: "Studying", address: "245 East Ave, Ithaca, NY 14850", info: "Physical Science Building. U also have a nice butt. But anyways, let's get physical tonight.")
//        let Duffield = Location(locationName: "Duffield", category: "Studying", address: "343 Campus Rd, Ithaca, NY 14853", info: "Where a bunch of losers go to on a Friday night. Where people grind work but wanna grind something else?")
//        let Upson = Location(locationName: "Upson", category: "Studying", address: "124 Hoy Rd, Ithaca, NY 14850", info: "What's down daughter?")
//        let Mann_Library = Location(locationName: "Mann Library", category: "Studying", address: "237 Mann Dr, Ithaca, NY 14850", info: "This is kinda sexist. lowkey offensive. More like women's library HA")
//        let Uris_Library = Location(locationName: "Uris Library", category: "Studying", address: "160 Ho Plaza, Ithaca, NY 14853", info: "Ur - is? More like Ur - Was.")
//        let The_Slope = Location(locationName: "The Slope", category: "Hotspots", address: "Libe Slope, Ithaca, Ny 14853", info: "The slope")
//        let The_Clocktower = Location(locationName: "The Clocktower", category: "Hotspots", address: "Towers Rd, Ithaca, NY 14850", info: "on everyone's instagram story at least once when they visit. Bingadingalee teehe.")
//        let Ag_Quad = Location(locationName: "Ag Quad", category: "Hotspots", address: "237 Mann Dr, Ithaca, NY 14853", info: "Silver quad. But you shouldn't come here because you are golden. Don't settle for less.")
//        let Arts_Quad = Location(locationName: "Arts Quad", category: "Hotspots", address: "Arts Quad, Ithaca, NY 14850", info: "Where all the fun activities are held. Shrek is played here.")
//        let Botanical_Gardens = Location(locationName: "Botanical Gardens", category: "Hotspots", address: "124 Comstock Knoll Dr, Ithaca, NY 14850", info: "May showers bring May flowers. Keep your head up <3")
//        let Donlon = Location(locationName: "Donlon", category: "Dorms", address: "57 Northcross Rd, Ithaca, NY 14853", info: "Where people practice absintence year round. Nothing to see here :)")
//        let CKB = Location(locationName: "CKB", category: "Dorms", address: "148 Cradit Farm Dr, Ithaca, NY 14850", info: "Very pretty dorm, but the rooms do be small.")
//        let Clara_Dickson = Location(locationName: "Clara Dickson", category: "Dorms", address: "21 Northcross Rd, Ithaca, NY 14853", info: "Get some Dick-Son. Use protection!")
//        let Cascadilla = Location(locationName: "Cascadilla", category: "Dorms", address: "Cascadilla Hall, Ithaca, NY 14850", info: "Most people don't know where this is but is basically by Four Seasons.")
//        let Cook = Location(locationName: "Cook", category: "Dorms", address: "Gothics Way, Ithaca, NY 14850", info: "Bomb food here. But can I cook for you one day?")
//
//        locationArray = [RPCC, Louies, Trillium, Goldies, Terrace, Helen_Newman, Noyes, Teagle_Down, Beebe_Lake_Trail, Cascadilla_Gorge_Trail, PSB, Duffield, Upson, Mann_Library, Uris_Library, The_Slope, The_Clocktower, Ag_Quad, Arts_Quad, Botanical_Gardens, Donlon, CKB, Clara_Dickson, Cascadilla, Cook]
        
        NetworkManager.getAllAttractions { attractions in
            self.displayedLocationsArray = attractions
            self.locationArray = attractions
            self.locationCollectionView.reloadData()
        }
        
        
//        displayedLocationsArray = locationArray
        
        // filterArray: [Filter]
        // Filter {name: "Food", selected: True/False}
        filterArray = [Filter(name: "Food", selected: false), Filter(name: "Fitness", selected: false), Filter(name: "Studying", selected: false), Filter(name:"Hotspots", selected: false), Filter(name: "Dorm", selected: false)]
        
        filterTitleLabel = UILabel()
        filterTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        filterTitleLabel.text = "Filter By"
        filterTitleLabel.textColor = .gray
        view.addSubview(filterTitleLabel)
      
        locationTitleLabel = UILabel()
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.text = "Locations"
        locationTitleLabel.textColor = .gray
        view.addSubview(locationTitleLabel)
        
        let locationLayout = UICollectionViewFlowLayout()
        locationLayout.scrollDirection = .vertical
        locationLayout.minimumInteritemSpacing = 25
        locationLayout.minimumLineSpacing = 25
        locationLayout.itemSize = CGSize(width: 344, height: 300)
        locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: locationLayout)
        locationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        locationCollectionView.backgroundColor = .white
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        view.addSubview(locationCollectionView)
        
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.minimumInteritemSpacing = 4
        filterLayout.minimumLineSpacing = 15
        filterLayout.itemSize = CGSize(width: 100, height: 32)
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .white
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.allowsMultipleSelection = false
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        view.addSubview(filterCollectionView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            main_Icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            main_Icon.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            main_Icon.heightAnchor.constraint(equalTo: filterTitleLabel.heightAnchor),
            ])
        
        NSLayoutConstraint.activate([
            filterTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            filterTitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            filterTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            filterTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: filterTitleLabel.bottomAnchor, constant: 12),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            filterCollectionView.bottomAnchor.constraint(equalTo: filterTitleLabel.bottomAnchor, constant: 60),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            locationTitleLabel.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 10),
            locationTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            locationTitleLabel.bottomAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 60),
//            locationTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            locationCollectionView.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 8),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    var index: Int = 0

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        index = indexPath.item
        if collectionView == self.locationCollectionView {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
            
            let location = displayedLocationsArray[indexPath.item]
            cell.configure(with: location)
            cell.setNeedsUpdateConstraints()
            // so our subviews and cells actually get a layout
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            let filter = filterArray[indexPath.item]
            //filter: Filter (name, selected)
            cell.configure(with: filter)
            cell.setNeedsUpdateConstraints()
            // so our subviews and cells actually get a layout
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // number of cells we want
        if collectionView == self.locationCollectionView {
            return displayedLocationsArray.count
        }
        else {
            return filterArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            if !filterArray[indexPath.item].selected{
                for i in 0..<filterArray.count {
                    if i == indexPath.item{
                       filterArray[i].selected = true
                    }
                    else{
                        filterArray[i].selected = false
                    }
                }
                removeItems(filterType: "category", filterFor: filterArray[indexPath.item].name)
            } else{
                filterArray[indexPath.item].selected = false
                displayedLocationsArray = locationArray
                locationCollectionView.reloadData()
            }
            filterCollectionView.reloadData()
        } else {
            let locationViewController = PushViewController(id: (displayedLocationsArray[indexPath.item].id), name: displayedLocationsArray[indexPath.item].name, address: displayedLocationsArray[indexPath.item].address, image: displayedLocationsArray[indexPath.item].image)
            locationViewController.delegate = self
            locationViewController.modalPresentationStyle = .fullScreen
            navigationController?.present(locationViewController, animated: true, completion: nil)
        }
    }
    
    
    func removeItems(filterType: String, filterFor: String) {
        
        displayedLocationsArray = []
        for location in locationArray {
            if location.category == filterFor {
                displayedLocationsArray.append(location)
            }
        }
        
        locationCollectionView.reloadData()
    }

}

extension UINavigationController{
    func pushViewControllerFromRight(controller: UIViewController){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
    }
}
