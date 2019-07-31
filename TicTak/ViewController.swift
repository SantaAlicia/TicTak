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
    let game = Game.shared
    
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

        collectionCell.fillCell(type : game.gameBoard.cellAtIndex(indexPath.row).type)
        return collectionCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (game.playerMakesMoveAtIndex(indexPath.row)) {
            collectionView.reloadData()
            updateInfoLabels()
            updateEnabledControls()
        }
    }
}

extension ViewController {
    
private func startNewGame() {
        game.startNewGame()
        collectionView.reloadData()
        updateInfoLabels()
        updateEnabledControls()
}
    
private func beforeNewGame() {
        collectionView.reloadData()
        updateInfoLabels()
        updateEnabledControls()
}
    
private func updateInfoLabels () {
    switch game.state {
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
        switch game.currentPlayer {
        case Player.cross:
            return "Turn of Player \"Cross\""
            
        case Player.zero:
            return "Turn of Player \"Zero\""
        }
    }
    
    private func winnerText() -> String {
        
        guard let unwrapped = game.gameResult else {
            return ""
        }
        
        switch unwrapped {
        case GameWinner.crossWinner:
            return "Player \"Cross\" is the winner!"
            
        case GameWinner.zeroWinner:
            return "Player \"Zero\" is the winner!"
            
        case GameWinner.draw :
            return "Draw. Nobody's won"
        }
    }
    
    private func updateEnabledControls() {
        switch game.state {
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

