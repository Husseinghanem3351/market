abstract class SalesStates {}

class InitSalesState extends SalesStates {}

class AddProductToSalesState extends SalesStates {}

class AddInvoiceSuccessState extends SalesStates {}

class ChangeQuantityState extends SalesStates {}

class RemoveItemState extends SalesStates {}

class SearchByNameState extends SalesStates {}
class ShowAllInvoicesState extends SalesStates {}

class GetInvoicesSuccessState extends SalesStates {}

class DeleteInvoiceSuccessState extends SalesStates {}

class ChangePriceAndQuantityState extends SalesStates {}

class MakeDiscountState extends SalesStates {}
