//
//  ContentView.swift
//  Edutainment
//
//  Created by Jonson Allen on 2023-08-23.
//

import SwiftUI

struct ContentView: View {
    @State private var textPlaceHolder = ""
    @State private var startGame = false
    @State private var numberChoice = 2
    
    @State private var questions = [""]
    @State private var questionState = ""
    @State private var questionNumber = 2
    
    @State private var endGameAlert = false
    
    @State private var gamePoints = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                if startGame == false {
                    Stepper("\(numberChoice)", value: $numberChoice, in: 2...12) {_ in
                    }.padding()
                    Button("Start Game") {
                        startGameNow()
                    }
                }
            }.navigationTitle("Select your multipication table")
                .padding()
            VStack {
            if startGame == true {
                    VStack {
                        Text("What is \(questions[0])")
                        VStack {
                            TextField("Give your answer",
                                      text: $questionState).textFieldStyle(.roundedBorder)
                            Button("Submit Answer") {
                                validateAnswer()
                                nextQuestion()
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .alert("Game Done", isPresented: $endGameAlert) {
                            Button("Game Finish") {
                                resetGame()
                            }
                        }
                }
            }.padding()
        }
    }
    
    func startGameNow() {
        startGame = true
        print("Game Started")
        questions = ["\(numberChoice) x \(questionNumber)"]
        print(questions)
    }
    
    func nextQuestion() {
        if startGame == true {
            // function to move to next question in questions array
            questionNumber += 1
            questionState = ""
            questions = ["\(numberChoice) x \(questionNumber)"]
            print("\(questionNumber)")
        }
        if questionNumber == 12 {
            endGameAlert = true
        }
    }
    
    func validateAnswer() {
        var playerAnswer = Int(questionState)
        var validAnswer = numberChoice * questionNumber
        
        if validAnswer == playerAnswer {
            gamePoints += 1
            print("Game Points: \(gamePoints)")
            print("Winner")
        }
    }
    
    func resetGame() {
        textPlaceHolder = ""
        startGame = false
        numberChoice = 2
        
        questions = [""]
        questionState = ""
        questionNumber = 2
        
        endGameAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
