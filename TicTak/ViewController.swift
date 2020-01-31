//
//  ViewController.swift
//  TicTak
//
//  Created by SantaAlicia on 27/07/2019.
//  Copyright © 2019 SantaAlicia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var gameOverInfo: UILabel!
    @IBOutlet weak var gameInfo: UILabel!
    @IBOutlet weak var playWithComputerSwitch: UISwitch!
    
    private var embeddedViewController: CollectionViewController!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CollectionViewController,
                    segue.identifier == "collectionViewSegue" {
            self.embeddedViewController = vc
        }
    }
    
    func tuningView () {
        startButton.layer.cornerRadius = DesignConstants.cornerRadius
        startButton.clipsToBounds = true
        embeddedViewController.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "notebookBackground")!)
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "woodBackground")!)
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "oldBook1")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "oldBook1")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
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


extension ViewController {
    
    private func startNewGame() {
            game.startNewGame()
            preparationViewsAndContols()
            embeddedViewController.collectionView.isUserInteractionEnabled = true
    }
    
    private func preparationViewsAndContols() {
            embeddedViewController.collectionView.reloadData()
            updateInfoLabels()
            updateEnabledControls()
    }
        
    func playerMakesOneMove(_ i : Int) {
                    if (game.playerMakesMoveAtIndex(i)) {
                        
                        if ((playWithComputerSwitch.isOn) && (game.currentPlayer == Player.zero)) {
                            gameTimer?.invalidate()
                            gameTimer = nil
                        }
                        embeddedViewController.collectionView.reloadData()
                        updateInfoLabels()
                        updateEnabledControls()
                    }
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

