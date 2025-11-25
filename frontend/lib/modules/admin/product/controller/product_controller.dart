import 'package:dio/dio.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/core/utils/api_client.dart';
import 'package:dio/dio.dart' show FormData;
import 'package:get/get.dart' hide FormData;

class ProductController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<String> errorMessage = ''.obs;
  Rx<String> responseMessage = ''.obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Product> allProducts = <Product>[].obs; // Store all products (unfiltered)
  RxList<Product> favouriteProducts = <Product>[].obs;
  Rx<bool> isFavouritesLoading = false.obs;

  // Filter and search state
  RxString searchQuery = ''.obs;
  RxString selectedCategory = 'All'.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  RxDouble selectedMinPrice = 0.0.obs;
  RxDouble selectedMaxPrice = 0.0.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  // Calculate min and max prices from all products
  void _calculatePriceRange() {
    if (allProducts.isEmpty) {
      minPrice.value = 0.0;
      maxPrice.value = 100.0;
      selectedMinPrice.value = 0.0;
      selectedMaxPrice.value = 100.0;
      return;
    }

    final prices = allProducts.map((p) => p.price).toList();
    final calculatedMin = prices.reduce((a, b) => a < b ? a : b);
    final calculatedMax = prices.reduce((a, b) => a > b ? a : b);

    minPrice.value = calculatedMin;
    maxPrice.value = calculatedMax;

    // Initialize selected prices to full range if not already set or if out of range
    if (selectedMinPrice.value < calculatedMin ||
        selectedMaxPrice.value > calculatedMax ||
        (selectedMinPrice.value == 0.0 && selectedMaxPrice.value == 0.0)) {
      selectedMinPrice.value = calculatedMin;
      selectedMaxPrice.value = calculatedMax;
    }
  }

  // Apply search and filters
  void applyFilters({
    String? search,
    String? category,
    double? minPriceFilter,
    double? maxPriceFilter,
  }) {
    if (search != null) searchQuery.value = search;
    if (category != null) selectedCategory.value = category;
    if (minPriceFilter != null) selectedMinPrice.value = minPriceFilter;
    if (maxPriceFilter != null) selectedMaxPrice.value = maxPriceFilter;

    _filterProducts();
  }

  // Filter products based on search query and filters
  void _filterProducts() {
    var filtered = List<Product>.from(allProducts);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query);
      }).toList();
    }

    // Apply category filter
    if (selectedCategory.value != 'All') {
      filtered = filtered.where((product) {
        return product.category == selectedCategory.value;
      }).toList();
    }

    // Apply price filter
    filtered = filtered.where((product) {
      return product.price >= selectedMinPrice.value && product.price <= selectedMaxPrice.value;
    }).toList();

    products.value = filtered;
  }

  // Clear all filters
  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = 'All';
    selectedMinPrice.value = minPrice.value;
    selectedMaxPrice.value = maxPrice.value;
    _filterProducts();
  }

  Future<bool> addProduct(FormData data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.post('products/add', data: data);
      responseMessage.value = response['message'];
      final product = Product.fromJson(response['data']);
      allProducts.add(product);
      _calculatePriceRange();
      // Clear filters to show all products including the new one
      clearFilters();
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Product>> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.get('products/all');
      final data = response['data'] as List;
      allProducts.value = data.map((e) => Product.fromJson(e)).toList();
      _calculatePriceRange();
      _filterProducts(); // Apply current filters to new data
      return products;
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isProductFavourite(String productId) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.get(
        'products/favourite-status',
        queryParameters: {'productId': productId},
      );
      final isFavourite = response['data']['isFavourite'] as bool;
      return isFavourite;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<bool> toggleFavourite(String productId) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post('products/favourite', data: {'productId': productId});
      responseMessage.value = response['message'];
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<bool> updateProduct(FormData data) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final productId = data.fields.first.value;
      final allIndex = allProducts.indexWhere((product) => product.productId == productId);
      final response = await apiClient.put('products/update', data: data);
      responseMessage.value = response['message'];
      final updatedProduct = Product.fromJson(response['data']);
      if (allIndex != -1) {
        allProducts.removeAt(allIndex);
        allProducts.insert(allIndex, updatedProduct);
      }
      _calculatePriceRange();
      _filterProducts();
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      errorMessage.value = '';
      final response = await apiClient.post('products/delete', data: {'id': productId});
      responseMessage.value = response['message'];
      // remove the product from the list
      allProducts.removeWhere((product) => product.productId == productId);
      _calculatePriceRange();
      _filterProducts();
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<List<Product>> fetchUserFavourites() async {
    try {
      isFavouritesLoading.value = true;
      errorMessage.value = '';
      final response = await apiClient.get('users/favourites/all');
      final data = response['data'] as List;
      favouriteProducts.value = data.map((e) => Product.fromJson(e)).toList();
      return favouriteProducts;
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    } finally {
      isFavouritesLoading.value = false;
    }
  }
}
