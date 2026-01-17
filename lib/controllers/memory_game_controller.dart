import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mokrabela/models/memory_card_model.dart';

class MemoryGameController extends ChangeNotifier {
  List<MemoryCard> cards = [];
  MemoryCard? firstFlippedCard;
  MemoryCard? secondFlippedCard;
  bool isProcessing = false;

  int moves = 0;
  int matchedPairs = 0;
  int elapsedSeconds = 0;
  Timer? _timer;
  bool isGameComplete = false;

  MemoryGameController() {
    initializeGame();
  }

  void initializeGame() {
    cards = MemoryCard.generateCardPairs();
    firstFlippedCard = null;
    secondFlippedCard = null;
    isProcessing = false;
    moves = 0;
    matchedPairs = 0;
    elapsedSeconds = 0;
    isGameComplete = false;

    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isGameComplete) {
        elapsedSeconds++;
        notifyListeners();
      }
    });
  }

  void flipCard(MemoryCard card) {
    if (isProcessing || card.isFlipped || card.isMatched) return;

    // Flip the card
    final index = cards.indexWhere((c) => c.id == card.id);
    cards[index] = card.copyWith(isFlipped: true);

    if (firstFlippedCard == null) {
      // First card flipped
      firstFlippedCard = cards[index];
    } else if (secondFlippedCard == null) {
      // Second card flipped
      secondFlippedCard = cards[index];
      moves++;
      isProcessing = true;

      // Check for match after a delay
      Future.delayed(const Duration(milliseconds: 600), () {
        _checkForMatch();
      });
    }

    notifyListeners();
  }

  void _checkForMatch() {
    if (firstFlippedCard == null || secondFlippedCard == null) return;

    if (firstFlippedCard!.icon == secondFlippedCard!.icon) {
      // Match found!
      _markAsMatched(firstFlippedCard!);
      _markAsMatched(secondFlippedCard!);
      matchedPairs++;

      // Check if game is complete
      if (matchedPairs == 8) {
        isGameComplete = true;
        _timer?.cancel();
      }
    } else {
      // No match, flip back
      _flipBack(firstFlippedCard!);
      _flipBack(secondFlippedCard!);
    }

    firstFlippedCard = null;
    secondFlippedCard = null;
    isProcessing = false;
    notifyListeners();
  }

  void _markAsMatched(MemoryCard card) {
    final index = cards.indexWhere((c) => c.id == card.id);
    cards[index] = card.copyWith(isMatched: true, isFlipped: true);
  }

  void _flipBack(MemoryCard card) {
    final index = cards.indexWhere((c) => c.id == card.id);
    cards[index] = card.copyWith(isFlipped: false);
  }

  String get formattedTime {
    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
