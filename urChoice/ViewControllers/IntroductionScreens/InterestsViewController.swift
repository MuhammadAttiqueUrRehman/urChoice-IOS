//
//  InterestsViewController.swift
//  uChoice
//
//  Created by iOS Developer on 27/06/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit

var interestsIndex = [Int]()

class InterestsViewController: UIViewController{
    
    @IBOutlet weak var skipView: UIView!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isFromProfile = false
    var selectedInterests = [String]()
    var interestList = [InterestViewModel]()
   var selectedIndex = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interestList = self.getInterests()
        loadSelectedinterests()
       let itemsData = loadIntersts()
        if itemsData.count != 0{
           interestList = itemsData
        }
        setUpperCollectionLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    fileprivate func loadSelectedinterests() {
        for interest in selectedInterests {
            let matched = interestList.filter({$0.name == interest})
            matched.first?.isSelected = true
        }
        self.collectionView.reloadData()
    }
    func loadIntersts() -> [InterestViewModel] {
        guard let encodedData = UserDefaults.standard.array(forKey: "userInterests") as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(InterestViewModel.self, from: $0) }
    }

    fileprivate func moveToInterduction() {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "IntroductionViewController") as? IntroductionViewController
               self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSkip(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        selectedInterests = []
        for interest in interestList {
            if interest.isSelected {
                selectedInterests.append(interest.name)
                let indexString = String(interest.index)
                selectedIndex.append(indexString)
            }
        }
        let data = self.interestList.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: "userInterests")
       SubmitData()
       
    }
    func setUpperCollectionLayout() {
       let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:10,bottom:0,right:0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.isPagingEnabled = false
        layout.scrollDirection = .vertical
        let screenSize: CGRect = UIScreen.main.bounds
        if screenSize.height < 734 {
            layout.itemSize = CGSize(width:(collectionView.frame.width - 30) / 3 , height: (collectionView.frame.width - 30) / 3)
        }else{
        layout.itemSize = CGSize(width:(collectionView.frame.width - 30) / 3 , height: (collectionView.frame.width + 50) / 3)
        }
       
        collectionView.collectionViewLayout = layout
    }
    func SubmitData(){
        let url     = EndPoint.BASE_URL + "user/update-profile"
//        let order = orderlistdata(p_id: "1", qty: "1")
//        var orderlist = [orderlistdata]()
//        orderlist.append(order)
        var selectedIndexArray = [String]()
        for index in selectedIndex{
            if selectedIndexArray.count == 0{
                selectedIndexArray.append(index)
            }else{
                selectedIndexArray.append(",")
                selectedIndexArray.append(index)
            }
        }
       
        let param = ["interests": selectedIndex]
           
           
        
        postWebCallWithToken(url: url, params: param, webCallName: "sign-In", sender: self) { [self] (response, error) in
            if !error{
                print(response)
               
                let status = String(response["status"] as? Int ?? 404)
                let message =  String(response["message"] as? String ?? "Error")
                if status != "200"{
                    self.alert(message: message)
                }else{
                  showSnackBarGray(message: message)
                    if self.isFromProfile{
                        self.navigationController?.popViewController(animated: true)
                    }else{
                       
                        self.moveToInterduction()
                    }
                  
                    
                }
                
                
            }else{
                let message = String(response["message"] as? String ?? "Server Error")
                showSnackBarGray(message: message)
//                self.alert(message: error.description)
            }
        }
        
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension InterestsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.reuseIdentifier, for: indexPath) as! InterestCollectionViewCell
        cell.configure(with: interestList[indexPath.item])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.bounds.size.width - 40) / 3
//        return CGSize(width: width, height: (width + 40))
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        interestList[indexPath.item].isSelected = !interestList[indexPath.item].isSelected
        self.collectionView.reloadData()
    }
    
}

extension InterestsViewController {
    fileprivate func getInterests() -> [InterestViewModel] {
        var interests = [InterestViewModel]()
        let names = ["Animations", "Cats", "Coffee", "Dogs", "Fashion", "Food", "Movies", "Music", "Party", "Shopping", "Soccer", "Travel"]
        let images = ["animation_white", "cat_white", "coffee_white", "dog_white", "fashion_white", "food_white", "movies_white", "music_white", "party_white", "shopping_white", "soccer_white", "travel_white"]
        let selectedImages = ["animation_golden", "cat_golden", "coffee_golden", "dog_golden", "fashion_golden", "food_golden", "movie_golden", "music_golden", "party_golden", "shopping_golden", "soccer_golden", "travel_golden"]
        
        for index in 0..<names.count {
            let interest = InterestViewModel(name: names[index], icon: images[index], selectedImage: selectedImages[index], index: (index + 1))
            interests.append(interest)
        }
        
        return interests
    }
}
