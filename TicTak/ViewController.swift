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
        beforeNewGame()
    }
    
    func updateView () {
        startButton.layer.cornerRadius = DesignConstants.cornerRadius
        startButton.clipsToBounds = true
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "notebookBackground")!)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "woodBackground")!)
    }
    
    @IBAction func startNewGameButtonPressed(_ sender: Any) {
        startNewGame()
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

        collectionCell.fillCell(type : gameController.game.cellAtIndex(indexPath.row).type)
        return collectionCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (gameController.playerDoesTapInCellAtIndex(indexPath.row)) {
            collectionView.reloadData()
            updateInfoLabels()
            updateButtonState()
        }
    }
}

extension ViewController {
    
private func startNewGame() {
        gameController.startNewGame()
        collectionView.reloadData()
        updateInfoLabels()
        updateButtonState()
}
    
private func beforeNewGame() {
        collectionView.reloadData()
        updateInfoLabels()
        updateButtonState()
}
    
private func updateInfoLabels () {
    switch gameController.state {
        case GameState.isNotStarted:
            currentPlayerInfo.text = ""
            gameOverInfo.text = ""
            gameResultInfo.text = ""
            
        case GameState.isStarted:
            currentPlayerInfo.text = "First is Turn of Player \"Cross\""
            gameOverInfo.text = ""
            gameResultInfo.text = ""
            
        case GameState.isProceed:
            currentPlayerInfo.text = currentPlayerText()
            gameOverInfo.text = ""
            gameResultInfo.text = ""
        
        case GameState.isOver:
            currentPlayerInfo.text = ""
            gameOverInfo.text = "Game is Over!"
            gameResultInfo.text = winnerText()
        }
    }
    
    private func currentPlayerText() -> String {
        switch gameController.currentPlayer {
        case Player.cross:
            return "Turn of Player \"Cross\""
            
        case Player.zero:
            return "Turn of Player \"Zero\""
        }
    }
    
    private func winnerText() -> String {
        
        guard let unwrapped = gameController.gameResult else {
            return ""
        }
        
        switch unwrapped {
        case GameWinner.crossWinner:
            return "Player \"Cross\" is winner!"
            
        case GameWinner.zeroWinner:
            return "Player \"Zero\" is winner!"
            
        case GameWinner.draw :
            return "Draw. Nobody's won"
        }
    }
    
    private func updateButtonState() {
        switch gameController.state {
        case GameState.isNotStarted:
            startButton.isEnabled = true
            
        case GameState.isStarted:
            startButton.isEnabled = false
            
        case GameState.isProceed:
            startButton.isEnabled = false
            
        case GameState.isOver:
            startButton.isEnabled = true
        }
    }
    
}

