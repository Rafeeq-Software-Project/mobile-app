import 'package:flutter/material.dart';

@immutable
sealed class NavBarInvestorState {}

final class NavBarInvestorInitial extends NavBarInvestorState {}

final class IndexChanged extends NavBarInvestorState {}
