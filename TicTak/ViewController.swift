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
    
    func updateView () {
        startButton.layer.cornerRadius = 5
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "notebookBackground")!)
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

        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2
        cell.isUserInteractionEnabled = true
        
        let objectCell : Cell = gameController.game.playingField.arr[indexPath.row]
        cell.fillCell(cell: objectCell)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameController.game.changeItem(atIndex: indexPath.row, newValue: CrossCell())
        collectionView.reloadData()
    }
}

