//
//  IntroductionViewController.swift
//  uChoice
//
//  Created by iOS Developer on 28/06/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var btnStartApp: UIButton!
    
    let headingList = ["Discovery", "Add new friends", "Messaging"]
    let imageList = ["slider_first", "slider_second", "slider_third"]
    let detailList = ["Discover and meet new friends from around the world through uChioce",
                      "Add new uChoice friends to your friend list",
                      "Keep in touch with your frinds with text messaging"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStartApp.layer.cornerRadius = 22
        btnStartApp.layer.borderWidth = 1
        btnStartApp.layer.borderColor = UIColor().colorForHax("#D09715").cgColor
        pageController.currentPageIndicatorTintColor = UIColor().colorForHax("#D09715")
    }
    
    
    @IBAction func actionStartuChoice(_ sender: Any) {
       
//        let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.MainContainerViewController)
//        self.navigationController?.setViewControllers([controller], animated: true)
        
        let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

extension IntroductionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroductionCollectionViewCell.reuseIdentifier, for: indexPath) as! IntroductionCollectionViewCell
        
        
            cell.lblBottomNote.isHidden = true
        
        
        cell.lblTitle.text = headingList[indexPath.item]
        cell.lblDetails.text = detailList[indexPath.item]
        cell.imgSlider.image = UIImage(named: imageList[indexPath.item])
        cell.lblBottomNote.text = "uChoice Matches \n 1234567890"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = Int(targetContentOffset.pointee.x / collectionView.bounds.size.width)
        self.pageController.currentPage = item
        
        self.btnStartApp.isHidden = !(item == 2)
        self.pageController.isHidden = (item == 2)
    }
    
}
