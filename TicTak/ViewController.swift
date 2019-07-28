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
    @IBOutlet weak var currentPlayerInfo: UILabel!
    @IBOutlet weak var gameOverInfo: UILabel!
    @IBOutlet weak var gameResultInfo: UILabel!
    
    let reuseIdentifier = "ticTakCell"
    let gameController = GameController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        callFuncNewGame()
    }
    
    func updateView () {
        startButton.layer.cornerRadius = DesignConstants.cornerRadius
        startButton.clipsToBounds = true
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "notebookBackground")!)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "woodBackground")!)
    }
    
    func updateInfoLabels () {
        currentPlayerInfo.text = gameController.textAboutCurrentPlayer()
        gameOverInfo.text = gameController.textGameOver()
    }
    
    func callFuncNewGame() {
        gameController.startNewGame()
        collectionView.reloadData()
        updateInfoLabels()
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        callFuncNewGame()
    }
}

extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameConstants.gameDimension
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TicTacCollectionViewCell

        collectionCell.layer.borderColor = UIColor.lightGray.cgColor
        collectionCell.layer.borderWidth = 2
        collectionCell.isUserInteractionEnabled = true

        collectionCell.fillCell(type : gameController.typeOfCellInPosition(index : indexPath.row))
        return collectionCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (gameController.playerChangedCellBy(index: indexPath.row)) {
            collectionView.reloadData()
            updateInfoLabels()
        }
    }
}

