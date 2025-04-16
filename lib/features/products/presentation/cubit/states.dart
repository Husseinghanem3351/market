abstract class ProductsStates {}

class InitSalesState extends ProductsStates {}

class GetProductsSuccessState extends ProductsStates {}

class DeleteProductSuccessState extends ProductsStates {}

class SearchProductSuccessState extends ProductsStates {}

class EditProductSuccessState extends ProductsStates {}

class AddOrRemoveProductCatState extends ProductsStates {}

class AddCategorySuccessState extends ProductsStates {}

class GetCategoriesSuccessState extends ProductsStates {}

class AddProductsToCategoriesSuccessState extends ProductsStates {}

class ChangeDollarPriceSuccess extends ProductsStates {}
