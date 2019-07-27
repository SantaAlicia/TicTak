//
//  ViewController.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    
    let reuseIdentifier = "ticTakCell"
    let gameController = GameController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: 120)
//        }
//    }
    
    func updateView () {
        startButton.layer.cornerRadius = 5
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        collectionView.reloadData()
        gameController.startNewGame()
    }
}

extension ViewController: UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TicCollectionViewCell
        cell.imgView.backgroundColor = UIColor.lightGray
        cell.emptyCell()
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

