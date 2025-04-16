// define the use cases here call it in cubit
import 'package:market/features/employers/data/models/employer_model.dart';
import 'package:market/features/employers/data/repositories/employers_repositories_implementation.dart';
import 'package:market/features/employers/domain/repositories/employers_repositories.dart';
import 'package:market/features/employers/domain/use_cases/add_employer_use_case.dart';
import 'package:market/features/employers/domain/use_cases/get_employers_use_case.dart';
import 'package:market/features/employers/domain/use_cases/update_employer_use_case.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/data/repositories/products_repositories_implementation.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/features/purchase/data/repositories/purchases_repositories_implementation.dart';
import 'package:market/features/purchase/domain/repositories/purchases_repositories.dart';
import 'package:market/features/purchase/domain/use_cases/add_purchase_use_case.dart';
import 'package:market/features/purchase/domain/use_cases/delete_purchase_use_case.dart';
import 'package:market/features/purchase/domain/use_cases/get_product_purchases_use_case.dart';
import 'package:market/features/purchase/domain/use_cases/get_purchases_use_case.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/data/repositories/invoice_repositories_implementation.dart';
import 'package:market/features/sales/data/repositories/sales_repositories_implementation.dart';
import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';
import 'package:market/features/sales/domain/repositories/sales_repositories.dart';
import 'package:market/features/sales/domain/use_cases/add_invoice_use_case.dart';
import 'package:market/features/sales/domain/use_cases/add_return_invoice_use_case.dart';
import 'package:market/features/sales/domain/use_cases/delete_invoice_use_case.dart';
import 'package:market/features/sales/domain/use_cases/delete_sales_use_case.dart';
import 'package:market/features/sales/domain/use_cases/get_invoices_day_use_case.dart';
import 'package:market/features/sales/domain/use_cases/get_product_sales_use_case.dart';
import 'package:market/features/sales/domain/use_cases/get_sale_date_use_case.dart';

import '../features/employers/domain/use_cases/delete_employer_use_case.dart';
import '../features/products/domain/entities/category.dart';
import '../features/products/domain/use_cases/add_category_use_case.dart';
import '../features/products/domain/use_cases/add_products_to_categories_use_case.dart';
import '../features/products/domain/use_cases/delete_product_use_case.dart';
import '../features/products/domain/use_cases/edit_product_use_case.dart';
import '../features/products/domain/use_cases/get_cat_products.dart';
import '../features/products/domain/use_cases/get_categories.dart';
import '../features/products/domain/use_cases/get_products_use_case.dart';
import '../features/products/domain/use_cases/search_product_by_name_use_case.dart';
import '../features/products/domain/use_cases/search_product_use_case.dart';
import '../features/purchase/domain/use_cases/update_purchase_use_case.dart';
import '../features/sales/domain/use_cases/get_invoices_use_case.dart';
import '../features/sales/domain/use_cases/get_return_invoices_use_case.dart';

class SalesUseCases {
  static SalesRepositories salesRepositories =
      SalesRepositoriesImplementation();
  static InvoiceRepositories invoiceRepositories =
      InvoiceRepositoriesImplementation();

  static addInvoiceUseCase(InvoiceModel invoice) =>
      AddInvoiceUseCase(invoiceRepositories)(invoice);

  static addReturnInvoiceUseCase(InvoiceModel invoice) =>
      AddReturnInvoiceUseCase(invoiceRepositories)(invoice);

  static deleteInvoiceUseCase(int id) =>
      DeleteInvoiceUseCase(invoiceRepositories)(id);

  static deleteSalesUseCase(SaleModel saleModel) =>
      DeleteSalesUseCase(salesRepositories)(saleModel);

  static getInvoicesDayUseCase(String date) =>
      GetInvoicesDayUseCase(invoiceRepositories)(date);

  static getInvoicesUseCase() => GetInvoicesUseCase(invoiceRepositories)();

  static getReturnInvoicesUseCase() =>
      GetReturnInvoicesUseCase(invoiceRepositories)();

  static getProductSalesUseCase(String productId) =>
      GetProductSalesUseCase(salesRepositories)(productId);

  static getSaleDateUseCase(int invoiceNumber) =>
      GetSaleDateUseCase(invoiceRepositories)(invoiceNumber);
}

class ProductsUseCases {
  static ProductsRepositories productsRepositories = ProductsRepositoriesImplementation();

  static getProductsUseCase() => GetProductsUseCase(productsRepositories)();

  static getCategoriesUseCase() => GetCategories(productsRepositories)();

  static getCatProducts(int id) => GetCatProducts(productsRepositories)(id);

  static editProductsUseCase(ProductModel productModel) =>
      EditProductUseCase(productsRepositories)(productModel);

  static searchProductUseCase(String id) =>
      SearchProductUseCase(productsRepositories)(id);

  static deleteProductUseCase(String id) =>
      DeleteProductUseCase(productsRepositories)(id);

  static searchProductByNameUseCase(String name) =>
      SearchProductByNameUseCase(productsRepositories)(name);

  static addCategoryUseCase(CategoryEntity category) =>
      AddCategoryUseCase(productsRepositories)(category);

  static addProductsToCategoriesUseCase(
          List<String> products, int categoryId) =>
      AddProductsToCategoriesUseCase(productsRepositories)(
          products, categoryId);
}

class PurchasesUseCases {
  static PurchasesRepositories purchasesRepositories =
      PurchasesRepositoriesImplementation();

  static addPurchaseUseCase(PurchaseModel purchaseModel) =>
      AddPurchaseUseCase(purchasesRepositories)(purchaseModel);

  static deletePurchaseUseCase(int id) =>
      DeletePurchaseUseCase(purchasesRepositories)(id);

  static getProductPurchaseUseCase(String id) =>
      GetProductPurchasesUseCase(purchasesRepositories)(id);

  static getPurchasesUseCase() => GetPurchasesUseCase(purchasesRepositories)();

  static updatePurchaseUseCase(PurchaseModel purchaseModel) =>
      UpdatePurchaseUseCase(purchasesRepositories)(purchaseModel);
}

class EmployersUseCases {
  static EmployersRepositories employersRepositories =
      EmployersRepositoriesImplementation();

  static addEmployerUseCase(EmployerModel employersModel) =>
      AddEmployerUseCase(employersRepositories)(employersModel);

  static deleteEmployerUseCase(int id) =>
      DeleteEmployerUseCase(employersRepositories)(id);

  static getEmployersUseCase() => GetEmployersUseCase(employersRepositories)();

  static updateEmployerUseCase(EmployerModel employersModel) =>
      UpdateEmployerUseCase(employersRepositories)(employersModel);
}
