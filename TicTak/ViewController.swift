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
        startButton.layer.cornerRadius = 6
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TicCollectionViewCell

        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2
        cell.isUserInteractionEnabled = true

        cell.fillCell(type : gameController.typeOfCellinPosition(index : indexPath.row))
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (gameController.playerChangeCellBy(index: indexPath.row)) {
            collectionView.reloadData()
            updateInfoLabels()
        }
    }
    
}

