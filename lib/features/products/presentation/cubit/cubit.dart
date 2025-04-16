import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/data/data_sources/products_local_data_source.dart';
import 'package:market/features/products/data/models/product_operation_model.dart';
import 'package:market/features/products/domain/entities/category.dart';
import 'package:market/features/products/presentation/cubit/states.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/global/edit_dollar_price.dart';

import '../../../../global/global_methods.dart';
import '../../../../global/use_cases.dart';
import '../../data/models/product_model.dart';
import '../screens/cat_products.dart';
import '../screens/categories.dart';
import '../screens/choose_category_products.dart';
import '../screens/product_operations.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(InitSalesState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  List<ProductModel>? products = [];
  List<CategoryEntity>? categories = [];
  List<ProductOperationModel> productOperations = [];
  List<ProductModel>? wrongQuantityProducts = [];
  List<ProductModel>? categoryProducts = [];

  Future<void> getProducts() async {
    products = await ProductsUseCases.getProductsUseCase();
    emit(GetProductsSuccessState());
  }

  Future<void> navigateToProductOperation(String productId, context) async {
    productOperations.clear();
    List<PurchaseModel>? purchases = [];
    List<SaleModel>? sales = [];
    purchases = await PurchasesUseCases.getProductPurchaseUseCase(productId);
    sales = await SalesUseCases.getProductSalesUseCase(productId);

    sales?.forEach(
      (element) async {
        String date =
            await SalesUseCases.getSaleDateUseCase(element.saleInvoice!);
        productOperations.add(
          ProductOperationModel(
            name: element.productName,
            price: element.price,
            quantity: element.quantity,
            operationType: 'sell',
            date: date,
          ),
        );
      },
    );

    purchases?.forEach(
      (element) {
        productOperations.add(ProductOperationModel(
            name: element.productName,
            price: element.buyingPrice,
            quantity: element.quantity,
            operationType: 'buy',
            date: element.dateAndTime));
      },
    );
    productOperations.sort(
      (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)),
    );

    navigateTo(
      context,
      ProductOperations(
        productsOperation: productOperations,
      ),
    );
  }

  Future<void> getWrongQuantityProducts() async {
    wrongQuantityProducts?.clear();
    for (int i = 0; i < products!.length; i++) {
      if (products![i].quantity <= 0) {
        wrongQuantityProducts?.add(products![i]);
      }
    }
  }

  Future<void> editProduct(ProductModel product) async {
    ProductsUseCases.editProductsUseCase(product);
    int? index = products?.indexWhere(
      (element) {
        return element.id == product.id;
      },
    );
    products![index!] = product;
    getWrongQuantityProducts();
    emit(EditProductSuccessState());
  }

  Future<void> searchProduct(String id) async {
    ProductsUseCases.searchProductUseCase(id);
    emit(SearchProductSuccessState());
  }

  Future<void> deleteProduct(String id,context) async {
    bool? insure=await insureDialog(context, 'هل انت متاكد انك تريد حذف هضا المنتج');

    if(insure==true){
      ProductsUseCases.deleteProductUseCase(id);
      Navigator.of(context).pop();
      getProducts();
      emit(DeleteProductSuccessState());
    }
  }

  Future<void> searchProductByName(String name) async {
    products = await ProductsUseCases.searchProductByNameUseCase(name);
    emit(SearchProductSuccessState());
  }

  Future<void> navigateToCategoryProducts(int id, context) async {
    categoryProducts = await ProductsUseCases.getCatProducts(id);
    navigateTo(
        context, CatProducts(products: categoryProducts ?? [], catId: id));
  }

  Future<void> navigateToCategories(context) async {
    categories = await ProductsUseCases.getCategoriesUseCase();
    navigateTo(
      context,
      Categories(
        categories: ProductsCubit.get(context).categories ?? [],
      ),
    );
    emit(GetCategoriesSuccessState());
  }

  Future<void> addCategory(CategoryEntity category, context) async {
    int id = await ProductsUseCases.addCategoryUseCase(category);
    ProductsCubit.get(context).categoryProducts!.clear();
    navigateTo(
      context,
      ChooseCategoryProducts(
        catId: id,
      ),
    );
    emit(AddCategorySuccessState());
  }

  Future<void> addOrRemoveProduct(bool value, int index) async {
    if (value) {
      categoryProducts?.add(products![index]);
      products?.removeAt(index);
    } else {
      products?.add(categoryProducts![index]);
      categoryProducts!.removeAt(index);
    }
    emit(AddOrRemoveProductCatState());
  }

  Future<void> addProductsToCat(int categoryId) async {
    List<String> categoryProductsIds = categoryProducts!
        .map(
          (e) => e.id,
        )
        .toList();
    await ProductsUseCases.addProductsToCategoriesUseCase(
        categoryProductsIds, categoryId);
    emit(AddProductsToCategoriesSuccessState());
  }

  Future<void> navigateToChooseProducts(context, int catId) async {
    navigateTo(
      context,
      ChooseCategoryProducts(
        catId: catId,
      ),
    );
  }

  Future<void> changeDollarPrice() async {
    EditDollarPrice.isChange = true;
    emit(ChangeDollarPriceSuccess());
  }

  Future<void> editProductsDollarPrice(
      {required List<ProductModel> products}) async {
    EditDollarPrice.isChange = false;
    for (var e in products) {
      editProduct(e);
    }

    EditDollarPrice.editingProducts.clear();
  }

  Future<void> editCategory(CategoryEntity cat,context) async {
    await ProductsLocalDataSourceImplementation().editCategory(cat);
    Navigator.of(context).pop(true);
    navigateToCategories(context);
  }

  Future<void> deleteCategory(int catId,context) async {
    await ProductsLocalDataSourceImplementation().deleteCategory(catId);
    Navigator.of(context).pop(true);
    navigateToCategories(context);
  }
}
