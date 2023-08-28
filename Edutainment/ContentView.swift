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
    
    @State private var nextQuestionState = false
    
    @State private var endGameAlert = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var submitRightAlert = false
    
    
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
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("Try Again", role: .cancel) {}
                    } message: {
                        Text(errorMessage)
                    }
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
        if startGame == true && nextQuestionState == true {
            // function to move to next question in questions array
            questionNumber += 1
            questionState = ""
            questions = ["\(numberChoice) x \(questionNumber)"]
            nextQuestionState = false
            print("\(questionNumber)")
        }
        if questionNumber == 12 {
            endGameAlert = true
        }
    }
    
    func validateAnswer() {
        let playerAnswer = Int(questionState)
        let validAnswer = numberChoice * questionNumber
        
        guard isFilled(answer: questionState) else {
            answerError(message: "Enter Something", title: "Please enter your answer!")
            return
        }
        
        guard isNumber(answer: questionState) else {
            answerError(message: "Enter a Number!", title: "Please no letters!")
            return
        }
        
        guard isWrong(answer: questionState) else {
            answerError(message: "Wrong Answer!", title: "Think Harder!")
            return
        }
        
        if validAnswer == playerAnswer {
            gamePoints += 1
            submitRightAlert = true
            nextQuestionState = true
            showingError = false
            print("Game Points: \(gamePoints)")
            print("Winner")
        }
        
        
    }
    
    func isNumber(answer: String) -> Bool {
        if let _ = Int(answer) {
            return true
        }
        return false
    }
    
    func isFilled(answer: String) -> Bool {
        let playersAnswer = answer
        if playersAnswer.count > 0 {
            return true
        }
        return false
    }
    
    func isWrong(answer: String) -> Bool {
        let playerAnswer = Int(answer)
        let validAnswer = numberChoice * questionNumber
        
        if validAnswer == playerAnswer {
            return true
        }
        gamePoints -= 1
        return false
    }
    
    func answerError(message: String, title: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func resetGame() {
        textPlaceHolder = ""
        startGame = false
        numberChoice = 2
        
        questions = [""]
        questionState = ""
        questionNumber = 2
        gamePoints = 0
        
        nextQuestionState = false
        
        endGameAlert = false
        submitRightAlert = false
        
        errorTitle = ""
        errorMessage = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
