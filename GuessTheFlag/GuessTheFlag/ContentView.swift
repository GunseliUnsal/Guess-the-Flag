//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Günseli Ünsal on 19.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain","UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var questionsAsked = 0
    @State private var incorrectAnswers = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.bold))
                
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagTapped(number)
                        }, label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.weight(.heavy))
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading){
                    Text("Questions: \(questionsAsked)/10")
                        .foregroundStyle(.white)
                        .font(.title3.weight(.semibold))
                    Text("Wrong Answers: \(incorrectAnswers)/3")
                        .foregroundStyle(.white)
                        .font(.title3.weight(.semibold))
                }
                
                            }
            .padding(20)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(score)")
        }
        .alert("👾 GAME OVER", isPresented: $gameOver) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is: \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        questionsAsked += 1
        
        if number == correctAnswer {
            scoreTitle = "✅ Correct!"
            score += 10
        } else {
            scoreTitle = "❌ False!"
            incorrectAnswers += 1
        }
        
        if questionsAsked == 10 || incorrectAnswers == 3 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        questionsAsked = 0
        incorrectAnswers = 0
        gameOver = false
        askQuestion()
    }
}

#Preview {
    ContentView()
}
