#include "JavaNativeLink/Exporter.h"
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <random>
#include <sstream>
#include <chrono>

// =============================================================================
// CardGame — Blackjack game engine
//
// All game logic lives here in C++. The Java side only handles UI rendering.
// Cards are represented as 2-character strings: rank + suit
//   Ranks: A, 2-9, T (10), J, Q, K
//   Suits: S (spades), H (hearts), D (diamonds), C (clubs)
//   Examples: "AS" = Ace of Spades, "TH" = 10 of Hearts, "KD" = King of Diamonds
// =============================================================================

struct CardGame {
    // Game state
    std::string status;      // "waiting", "playing", "player_bust", "dealer_bust", "player_win", "dealer_win", "push"
    int playerScore;
    int dealerScore;
    int playerWins;
    int dealerWins;
    int pushes;

    CardGame()
        : status("waiting"), playerScore(0), dealerScore(0),
          playerWins(0), dealerWins(0), pushes(0) {
        initDeck();
        shuffleDeck();
    }

    // Start a new round
    void startNewGame() {
        initDeck();
        shuffleDeck();
        playerHand.clear();
        dealerHand.clear();
        status = "playing";

        // Deal 2 cards each
        playerHand.push_back(drawCard());
        dealerHand.push_back(drawCard());
        playerHand.push_back(drawCard());
        dealerHand.push_back(drawCard());

        playerScore = calculateScore(playerHand);
        dealerScore = calculateScore(dealerHand);

        // Check for natural blackjack
        if (playerScore == 21 && dealerScore == 21) {
            status = "push";
            pushes++;
        } else if (playerScore == 21) {
            status = "player_win";
            playerWins++;
        } else if (dealerScore == 21) {
            status = "dealer_win";
            dealerWins++;
        }
    }

    // Player draws a card
    void playerHit() {
        if (status != "playing") return;

        playerHand.push_back(drawCard());
        playerScore = calculateScore(playerHand);

        if (playerScore > 21) {
            status = "player_bust";
            dealerWins++;
        } else if (playerScore == 21) {
            // Auto-stand on 21
            playerStand();
        }
    }

    // Player stands; dealer plays
    void playerStand() {
        if (status != "playing") return;

        // Dealer draws until 17 or higher
        dealerScore = calculateScore(dealerHand);
        while (dealerScore < 17) {
            dealerHand.push_back(drawCard());
            dealerScore = calculateScore(dealerHand);
        }

        // Determine winner
        if (dealerScore > 21) {
            status = "dealer_bust";
            playerWins++;
        } else if (playerScore > dealerScore) {
            status = "player_win";
            playerWins++;
        } else if (dealerScore > playerScore) {
            status = "dealer_win";
            dealerWins++;
        } else {
            status = "push";
            pushes++;
        }
    }

    int getPlayerScore() { return playerScore; }
    int getDealerScore() { return dealerScore; }
    int getPlayerWins() { return playerWins; }
    int getDealerWins() { return dealerWins; }
    int getPushes() { return pushes; }

    // Returns comma-separated card IDs: "AS,KH,3D"
    std::string getPlayerCards() {
        return joinCards(playerHand);
    }

    // Returns comma-separated card IDs (only first card visible until game over)
    std::string getDealerCards() {
        return joinCards(dealerHand);
    }

    std::string getGameStatus() {
        return status;
    }

    int getPlayerCardCount() { return static_cast<int>(playerHand.size()); }
    int getDealerCardCount() { return static_cast<int>(dealerHand.size()); }

    // Returns 1 if game is over, 0 if still playing
    int isGameOver() {
        return (status != "playing" && status != "waiting") ? 1 : 0;
    }

private:
    std::vector<std::string> deck;
    std::vector<std::string> playerHand;
    std::vector<std::string> dealerHand;

    void initDeck() {
        deck.clear();
        const char* ranks[] = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"};
        const char* suits[] = {"S", "H", "D", "C"};
        for (auto r : ranks) {
            for (auto s : suits) {
                deck.push_back(std::string(r) + s);
            }
        }
    }

    void shuffleDeck() {
        auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
        std::mt19937 rng(static_cast<unsigned>(seed));
        std::shuffle(deck.begin(), deck.end(), rng);
    }

    std::string drawCard() {
        if (deck.empty()) {
            initDeck();
            shuffleDeck();
        }
        std::string card = deck.back();
        deck.pop_back();
        return card;
    }

    int cardValue(const std::string& card) {
        char rank = card[0];
        switch (rank) {
            case 'A': return 11;
            case '2': return 2;
            case '3': return 3;
            case '4': return 4;
            case '5': return 5;
            case '6': return 6;
            case '7': return 7;
            case '8': return 8;
            case '9': return 9;
            case 'T': case 'J': case 'Q': case 'K': return 10;
            default: return 0;
        }
    }

    int calculateScore(const std::vector<std::string>& hand) {
        int score = 0;
        int aces = 0;
        for (const auto& card : hand) {
            int val = cardValue(card);
            if (val == 11) aces++;
            score += val;
        }
        // Adjust aces from 11 to 1 if bust
        while (score > 21 && aces > 0) {
            score -= 10;
            aces--;
        }
        return score;
    }

    std::string joinCards(const std::vector<std::string>& hand) {
        std::ostringstream oss;
        for (size_t i = 0; i < hand.size(); ++i) {
            if (i > 0) oss << ",";
            oss << hand[i];
        }
        return oss.str();
    }
};

JNL_EXPORT_CLASS(CardGame);
