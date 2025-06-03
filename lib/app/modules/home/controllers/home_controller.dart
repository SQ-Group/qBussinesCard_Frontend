import 'package:get/get.dart';
import '../apiClient/apiClient.dart';
import '../model/qcard model.dart';

class HomeController extends GetxController {
  final apiService = ApiService();

  var isLoading = true.obs;
  var qCard = Rxn<Data>();

  late final String cardId;

  @override
  void onInit() {
    super.onInit();
    cardId = Uri.base.queryParameters['cardId'] ?? '';
    if (cardId.isNotEmpty) {
      fetchCardData(cardId);
    } else {
      print("cardId not found in URL");
      isLoading.value = false;
    }
  }

  void fetchCardData(String cardId) async {
    isLoading.value = true;
    final response = await apiService.fetchProfile(cardId);
    if (response != null && response.data != null) {
      qCard.value = response.data;
    }
    isLoading.value = false;
  }
}
