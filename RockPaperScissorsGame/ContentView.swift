//
//  ContentView.swift
//  RockPaperScissorsGame
//
//  Created by Abdul Adhil on 16/08/24.
//

struct ChoiceButtonStyle: View{
    var text: String
    var body: some View{
        Text(text)
            .font(.system(size: 100))
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 30))
    }
}

import SwiftUI

struct ContentView: View {
    
    @State private var currentChoice = ["👊🏻","✋🏻","✌🏻"].shuffled()
    @State private var move = Bool.random()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingResult = false
    @State private var showingReset = false
    @State private var question = 1
    
    let gameChoices = ["👊🏻","✋🏻","✌🏻"]
    let winingMoves = ["Paper", "Scissors", "Rock"]
    

    var body: some View {
        ZStack{
            RadialGradient(colors: [.blue,.black], center: .top, startRadius: 100, endRadius: 900)
                .ignoresSafeArea()
            
            VStack(spacing:30){
                Spacer()
                
                Text("Rock Paper Scissor")
                    .foregroundStyle(.white)
                    .font(.largeTitle).bold()
                
                Text(currentChoice[correctAnswer])
                    .font(.system(size: 200))
                
                Text("Choose a move to \(move ? "Win" : "Lose")")
                    .font(.title2)
                    .foregroundStyle(.white)
                
                HStack{
                    Button{
                        choiceTapped(userChoice: "👊🏻", appChoice: currentChoice[correctAnswer],moveChoice: move)
                    } label:{
                        ChoiceButtonStyle(text: "👊🏻")
                    }
                    Button{
                        choiceTapped(userChoice: "✋🏻", appChoice: currentChoice[correctAnswer],moveChoice: move)
                    } label:{
                        ChoiceButtonStyle(text: "✋🏻")
                    }
                    Button{
                        choiceTapped(userChoice: "✌🏻", appChoice: currentChoice[correctAnswer],moveChoice: move)
                    } label:{
                        ChoiceButtonStyle(text: "✌🏻")
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("\(question)/10")
                    .foregroundStyle(.gray)
                    .font(.headline.bold())
                Spacer()
                
            }
            
        }
        .alert("\(scoreTitle)",isPresented: $showingResult){
            
            Button("Ok"){
                currentChoice.shuffle()
                correctAnswer = Int.random(in: 0...2)
                move = Bool.random()
                question += 1
            }
            
        }
        
        .alert("Your Final Score: \(score)", isPresented: $showingReset){
                    Button("Reset the Game"){
                        question = 1
                        score = 0
                        currentChoice.shuffle()
                        correctAnswer = Int.random(in: 0...2)
                        move = Bool.random()
                    }
                }
        
    }
        
    
    func choiceTapped(userChoice: String, appChoice: String, moveChoice: Bool ){
        if(userChoice == "👊🏻" && appChoice == "✌🏻"  ||
           userChoice == "✌🏻" && appChoice == "✋🏻"  ||
           userChoice == "✋🏻" && appChoice == "👊🏻"
        ){
            if(!moveChoice){
                scoreTitle = "Wrong"
                score != 0 ? score -= 1 : nil
                
            }else{
                scoreTitle = "Correct"
                score += 1
            }
        }
        else{
            if(!moveChoice){
                scoreTitle = "Correct"
                score += 1
            }else{
                score != 0 ? score -= 1 : nil
                scoreTitle = "Wrong"
            }
            
        }
        
        
        if(question >= 10){
            showingReset = true
        }
        else{
            showingResult = true
        }
       
    }
}

#Preview {
    ContentView()
}
