//
//  ViewController.swift
//  Apple Pie
//
//  Created by segun Ajibade on 3/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords =  ["buccaneer","swift","glorious","incandescent","bug","Program"] //create an array of words
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totallosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        //let letterString = sender.title(for: .normal)!
        let letterString = sender.titleLabel!.text!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totallosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
           updateUI()
        }
    }

    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totallosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound ()
    }
    
    func newRound(){
      if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
      } else {
          enableLetterButtons(false)
        }
        
        
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
  }
}
