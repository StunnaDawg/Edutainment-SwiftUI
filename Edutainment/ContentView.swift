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
    @State private var questionState = [""]
    @State private var questionNumber = 2
    
    @State private var endGameAlert = false
    
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
            if startGame == true {
                VStack {
                    VStack {
                        Text("What is \(questions[0])")
                        VStack {
                            TextField("Give your answer",
                                      text: $questionState[0]).textFieldStyle(.roundedBorder)
                            Button("Submit Answer") {
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
            }
        }
    }
    
    func startGameNow() {
        startGame = true
        print("Game Started")
        questions = ["\(numberChoice) * \(questionNumber)"]
        print(questions)
    }
    
    func nextQuestion() {
        if startGame == true {
            // function to move to next question in questions array
            questionNumber += 1
            questions = ["\(numberChoice) * \(questionNumber)"]
            print("\(questionNumber)")
        }
        if questionNumber == 12 {
            endGameAlert = true
        }
    }
    
    func resetGame() {
        textPlaceHolder = ""
        startGame = false
        numberChoice = 2
        
        questions = [""]
        questionState = [""]
        questionNumber = 2
        
        endGameAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
