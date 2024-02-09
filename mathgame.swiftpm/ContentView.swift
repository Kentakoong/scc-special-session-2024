import SwiftUI

struct ContentView: View {
    
    @State private var number1: Int = Int.random(in: 1...10)
    @State private var number2: Int = Int.random(in: 1...10)
    @State private var userAnswer: String = ""
    @State private var correctAnswerCount: Int = 0
    @State private var showGameOverAlert: Bool = false
    
    var correctAnswer: Int {
        return number1 * number2
    }
    
    func nextProblem(_ newGame: Bool = false) {
        number1 = Int.random(in: 1...10)
        number2 = Int.random(in: 1...10)
        userAnswer = ""
        if newGame { correctAnswerCount = 0 }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Score: \(correctAnswerCount)")
                .font(.headline)
            Text("Guess or Calculate this")
            Text("\(number1) × \(number2) = ?")
                .font(.largeTitle)
                .fontWeight(.semibold)
            TextField("Your Answer", text: $userAnswer)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()
            if (!userAnswer.isEmpty) {
                Button("Check Answer") {
                    if let userAns = Int(userAnswer), userAns == correctAnswer {
                        correctAnswerCount += 1
                        nextProblem()
                    } else {
                        showGameOverAlert = true
                    }
                }
            }
        }.padding()
            .alert(isPresented: $showGameOverAlert, content: {
                Alert(title: Text("Game Over"), 
                      message: Text("Total Score \(correctAnswerCount)"), 
                      primaryButton: .default(Text("Yes"), action: { nextProblem(true)
                }),
                      secondaryButton: .cancel(Text("No")))
            })
    }
}
