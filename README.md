# 🃏 CardGame - iOS App

**CardGame** is a fast-paced, location-influenced card game for two players: **You vs. PC**. Based on who is farther north (by latitude), the player is placed on the left or right, and both players draw random cards until someone reaches 10 points. A timer adds pressure between rounds. Clean UI, smooth animations, and location-driven gameplay make this an exciting quick game!

---

## 📹 Demo Video

Watch it in action:  
🔗 [https://youtu.be/KHSht1gOwnc](https://youtu.be/KHSht1gOwnc)

---

## 🎮 Game Rules

- On app launch, user enters their **name**.
- The app uses **device location** to determine player's side (north/south).
- Player and PC draw random cards every few seconds.
- Higher card value wins the round and earns a point.
- First to **10 points** wins.
- The game shows a **Game Over screen** with the winner's name and score.

---

## 🧩 Features

- 🌍 Uses CoreLocation to determine player’s position.
- 🗂️ Full deck of cards, each image named consistently (e.g., `2_of_hearts`, `13_of_spades`).
- ⏱ Countdown timer: 5 seconds per round.
- 🎯 Points auto-increment and update on screen.
- 🎉 Game over screen with final score and winner's name.
- 🧠 Simple, intuitive flow using UIKit and Storyboards.

---

## 🏗 Architecture

| Class | Role |
|-------|------|
| `ViewController.swift` | Home screen: enter name and fetch location |
| `GameController.swift` | Core game loop: random cards, score, timer |
| `gameOverController.swift` | Displays winner info and allows restarting |
| `AppDelegate.swift` | Standard app lifecycle management |

---

## 🛠 Technologies Used

- 🧪 Swift (iOS 16+)
- 🖼 UIKit & Storyboards
- 📍 CoreLocation
- 🕒 Timer
- 💾 UserDefaults (name storage)
- 🎴 UIImageView for dynamic card updates

---
