//
//  ContentView.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// renamed from GameState for challenge 3
enum GameCardState {
    case start, firstFlipped
}

// challenge 3
enum GameState {
    case initial, ongoing, finished, settings
}

struct MainView: View {
    // challenge 1 & 2
    @EnvironmentObject var deck: Deck
    @EnvironmentObject var scores: Scores

    // renamed from GameState for challenge 3
    @State private var gameCardState = GameCardState.start
    @State private var firstIndex: Int?
    @State private var secondIndex: Int?

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // challenge 1 & 2
    @State private var showSettings = false

    // challenge 3
    @State private var gameState = GameState.initial

    // challenge 4
    @State private var latestScore = Score(score: 0, date: Date())

    // challenge 1 & 2
    private var cardWidth: CGFloat {
        let fullWidth = 910
        let padding = 10
        let totalPadding = (deck.cardColumns + 1) * padding
        let totalWidth = fullWidth - totalPadding

        return CGFloat(totalWidth / deck.cardColumns)
    }

    // challenge 1 & 2
    private var cardHeight: CGFloat {
        let fullHeight = 450
        let padding = 10
        let totalPadding = (deck.cardRows + 1) * padding
        let totalHeight = fullHeight - totalPadding

        return CGFloat(totalHeight / deck.cardRows)
    }


    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(white: 0.3), .black]), startPoint: .top, endPoint: .bottom)

            VStack {
                Image(decorative: "pairs")

                ZStack {
                    // challenge 1
                    GridStack(rows: deck.cardRows, columns: deck.cardColumns, content: card)
                        .layoutPriority(1)
                        .blur(radius: gameState == .ongoing ? 0 : 3)

                    // challenge 3
                    if gameState == .initial {
                        Button("Start Game") {
                            self.gameState = .ongoing
                        }
                        .buttonStyle(PairsButtonStyle())
                    }

                    // challenge 3
                    if gameState == .finished {
                        VStack {
                            Text("Score: \(timeRemaining)")
                                .padding(.bottom)

                            // challenge 4
                            Text("High scores")
                                .font(.body)
                            HighScoresView(scores: self.scores.get(), currentScore: latestScore)
                                .frame(width: 200)
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .padding(.bottom)

                            Button("Restart Game") {
                                self.restartGame()
                            }
                            .buttonStyle(PairsButtonStyle())
                        }
                        .modifier(PairsTextStyle())
                    }
                }

                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
            }
            .padding()

            // challenge 1, 2 & 3
            SettingsButton {
                self.gameState = .settings
                self.showSettings = true
            }
            .padding(.bottom, 10)
        }
        .onReceive(timer, perform: updateTimer)
        // challenge 1 & 2
        .sheet(isPresented: $showSettings) {
            SettingsView() {
                self.restartGame()
            }
            .environmentObject(self.deck)
        }
    }

    func card(atRow row: Int, column: Int) -> some View {
        let index = (row * deck.cardColumns) + column
        let part = deck.cardParts[index]

        return CardView(width: cardWidth, height: cardHeight, cardPart: part)
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text(part.text))
            .onTapGesture {
                self.flip(index)
            }
    }

    func flip(_ index: Int) {
        // challenge 3
        guard gameState == .ongoing else { return }

        guard deck.cardParts[index].state == .unflipped else { return }
        guard secondIndex == nil else { return }

        switch gameCardState {
        case .start:
            withAnimation {
                self.firstIndex = index
                self.deck.set(index, to: .flipped)
                self.gameCardState = .firstFlipped
            }
        case .firstFlipped:
            withAnimation {
                self.secondIndex = index
                self.deck.set(index, to: .flipped)
                self.checkMatches()
            }
        }
    }

    func match() {
        guard let first = firstIndex, let second = secondIndex else {
            fatalError("There must be 2 flipped cards before matching")
        }

        withAnimation {
            deck.set(first, to: .matched)
            deck.set(second, to: .matched)
        }

        reset()

        // challenge 3
        if deck.cardParts.filter({ $0.state == .unflipped }).isEmpty {
            gameState = .finished
            // challenge 4
            latestScore = Score(score: timeRemaining, date: Date())
            scores.add(score: latestScore)
        }
    }

    func noMatch() {
        guard let first = firstIndex, let second = secondIndex else {
            fatalError("There must be 2 flipped cards before matching")
        }

        withAnimation {
            deck.set(first, to: .unflipped)
            deck.set(second, to: .unflipped)
        }

        reset()
    }

    func reset() {
        firstIndex = nil
        secondIndex = nil
        gameCardState = .start
    }

    func checkMatches() {
        guard let first = firstIndex, let second = secondIndex else {
            fatalError("There must be 2 flipped cards before matching")
        }

        if deck.cardParts[first].id == deck.cardParts[second].id {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: match)
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: noMatch)
        }
    }

    func updateTimer(_ currentTime: Date) {
        // challenge 1, 2 & 3
        guard gameState == .ongoing else { return }

        let unmatched = self.deck.cardParts.filter { $0.state != .matched }
        guard unmatched.count > 0 else { return }

        if self.timeRemaining > 0 {
            self.timeRemaining -= 1
        }
        // challenge 3
        else {
            gameState = .finished
        }
    }

    // challenge 1, 2 & 3
    func restartGame() {
        deck.reloadData()
        gameState = .ongoing
        timeRemaining = 100
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Deck())
    }
}
