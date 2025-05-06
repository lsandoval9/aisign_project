import 'dart:convert';

import 'package:aisign_project/features/dashboard/domain/dashboard_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardDataNotifier
    extends StateNotifier<AsyncValue<DashboardDataModel>> {
  final Ref _ref;
  DashboardDataNotifier(this._ref) : super(const AsyncLoading()) {
    fetchDashboardData(); // Fetch data on initialization
  }

  Future<void> fetchDashboardData() async {
    state = const AsyncLoading();

    final jsonString = await rootBundle.loadString('assets/mocks/dashboard.json', cache: false);

    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final dashboardData = DashboardDataModel.fromJson(jsonData);

    state = AsyncData(dashboardData);
  }

  Future<void> refreshDashboardData() async {
    await fetchDashboardData();
  }
}

// 2. Define the StateNotifierProvider
final dashboardDataProvider = StateNotifierProvider<DashboardDataNotifier,
    AsyncValue<DashboardDataModel>>((ref) {
  return DashboardDataNotifier(ref);
});