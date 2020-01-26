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
    @IBOutlet weak var gameOverInfo: UILabel!
    @IBOutlet weak var gameInfo: UILabel!
    @IBOutlet weak var playWithComputerSwitch: UISwitch!
    
    let reuseIdentifier = "ticTakCell"
    
    private let sectionInsets = UIEdgeInsets(top: 0.0,
    left: 0.0,
    bottom: 0.0,
    right: 0.0)
    private let itemsPerRow: CGFloat = 3
    let game = Game.shared
    var gameTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tuningView()
       preparationViewsAndContols()
    }
    
    func tuningView () {
        startButton.layer.cornerRadius = DesignConstants.cornerRadius
        startButton.clipsToBounds = true
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "notebookBackground")!)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "woodBackground")!)
        playWithComputerSwitch.onTintColor = .black
        playWithComputerSwitch.tintColor = .black
    }
    
    @IBAction func startNewGameButtonPressed(_ sender: Any) {
        startNewGame()
    }
    @IBAction func playWithComputerChanged(_ sender: Any) {
        startNewGame()
    }
//    @IBAction func updateCell(_ sender: Any) {
//        udateCellsIfGameOver()
//    }
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
        
        collectionCell.isUserInteractionEnabled = true
        let isWinCell = game.isCellInsideWinCombination(index: indexPath.row)

        collectionCell.fillCell(type : game.gameBoard.cellAtIndex(indexPath.row).type, isWinCell: isWinCell )
        return collectionCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
   func playerMakesOneMove(_ i : Int) {
                if (game.playerMakesMoveAtIndex(i)) {
                    
                    if ((playWithComputerSwitch.isOn) && (game.currentPlayer == Player.zero)) {
                        gameTimer?.invalidate()
                        gameTimer = nil
                    }
                    collectionView.reloadData()
                    updateInfoLabels()
                    updateEnabledControls()
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                playerMakesOneMove(indexPath.row)
                if (game.state == GameState.isOver) {
                    gameTimer?.invalidate()
                    gameTimer = nil
                    collectionView.isUserInteractionEnabled = false
                    return
                }
                if ((playWithComputerSwitch.isOn) && (game.currentPlayer == Player.zero)) {
                    
                    guard let ramdomIndexFromEmptyCell = game.gameBoard.findOneEmptyCell() else {
                        return
                    }

                    gameTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { timer in
                        self.playerMakesOneMove(ramdomIndexFromEmptyCell)
                    })
                }
            }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//      //2
//      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//      let availableWidth = view.frame.width - paddingSpace
//      let widthPerItem = availableWidth / itemsPerRow
//
//      return CGSize(width: widthPerItem, height: widthPerItem)
//    }
    
//    //3
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//      return sectionInsets
//    }
//
//    // 4
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//      return sectionInsets.left
//    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let nbCol = 3
        

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        
//        print("***")
//             print(collectionView.bounds.size.width)
//             print(collectionView.bounds.size.height)
        
        let w = collectionView.bounds.size.width
        collectionView.bounds.size = CGSize(width: w, height: w)
        return CGSize(width: size, height: size)
    }
}

extension ViewController {
    
private func startNewGame() {
        game.startNewGame()
        preparationViewsAndContols()
        collectionView.isUserInteractionEnabled = true
}
    
private func preparationViewsAndContols() {
        collectionView.reloadData()
        updateInfoLabels()
        updateEnabledControls()
}
    
private func updateInfoLabels () {
    switch game.state {
        case GameState.isNotStarted, GameState.isStarted:
            gameInfo.text = "First is Turn of Player \"Cross\""
            gameInfo.font = UIFont(name: "MarkerFelt-Thin", size: 17.0)
            gameInfo.textColor = .black
            gameOverInfo.text = " "
        case GameState.isProceed:
            gameInfo.text = currentPlayerText()
            gameOverInfo.text = " "
        case GameState.isOver:
            gameInfo.font = UIFont(name: "MarkerFelt-Wide", size: 22.0)
            gameInfo.textColor = .red
            gameInfo.text = GameResultController.winnerText()
            gameOverInfo.text = "Game is Over!"
        }
    }
    
    private func currentPlayerText() -> String {
        let textZero : String!
        if (!playWithComputerSwitch.isOn) {
            textZero =  "Turn of Player \"Zero\""
        } else  {
            textZero = " "  }
        switch game.currentPlayer {
        case Player.cross:
            return "Turn of Player \"Cross\""
            
        case Player.zero:
            return textZero
            
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
    
//    private func udateCellsIfGameOver() {
//        if game.state != GameState.isOver {
//            return
//        }
//        //let set : Set<Int>? = game.winSet()
//        let indexPath = IndexPath(item: 1, section: 0)
//
//        let a = collectionView.cellForItem(at: indexPath)
//
//        if let cell = ((collectionView.cellForItem(at: indexPath)) as? TicTacCollectionViewCell) {
//            cell.imageView.image = UIImage(named: "scratch")
//        }
//    }
    
}

