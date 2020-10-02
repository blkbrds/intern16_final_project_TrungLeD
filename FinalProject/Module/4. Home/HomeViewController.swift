//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel = HomeViewModel()
        @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()
    }
        
        func configCollection() {
            let nib = UINib(nibName: "Home1CollectionViewCell", bundle: Bundle.main)
            collectionView.register(nib, forCellWithReuseIdentifier: "Home1CollectionViewCell")
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Home1CollectionViewCell", for: indexPath) as? Home1CollectionViewCell else {
                   return UICollectionViewCell()
               }
//               cell.viewModel = viewModel.viewModelForCell(at: indexPath)
               return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailVC = DetailViewController()
                   detailVC.viewModel = viewModel.getInforPitch(at: indexPath)
                   navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    extension HomeViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 150)
        }
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 12
        }
    }
