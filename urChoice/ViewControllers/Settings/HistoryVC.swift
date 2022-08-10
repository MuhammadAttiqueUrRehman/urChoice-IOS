//
//  HistoryVC.swift
//  urChoice
//
//  Created by Mazhar on 2022-02-09.
//

import UIKit

class HistoryVC: BaseViewController {

    @IBOutlet weak var collectionVu: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionLayout()
      
        
        
       
       
        // Do any additional setup after loading the view.
    }
    func setupNib(){
        let nib = UINib(nibName: "HistoryCVC", bundle: nil)
        collectionVu.register(nib, forCellWithReuseIdentifier:
                                "HistoryCVC")
       
       
   }
    func setCollectionLayout() {
       let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:10,bottom:0,right:10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionVu.isPagingEnabled = true
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:(collectionVu.frame.width - 30)/2 , height: 200)
       
        collectionVu.collectionViewLayout = layout
        setupNib()
       
        collectionVu.delegate = self
        collectionVu.dataSource = self
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension HistoryVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCVC", for: indexPath) as! HistoryCVC
//        setCollectionLayout()
           return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
           
            return CGSize(width:(collectionVu.frame.width - 30)/2 , height: 200)
        
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
            
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
   
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
    }
}


