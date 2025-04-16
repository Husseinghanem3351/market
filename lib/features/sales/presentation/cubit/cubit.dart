import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/data/repositories/products_repositories_implementation.dart';
import 'package:market/features/products/domain/use_cases/search_product_by_name_use_case.dart';
import 'package:market/features/products/domain/use_cases/search_product_use_case.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/screens/invoices.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';
import 'package:market/global/global_methods.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../global/use_cases.dart';

class SalesCubit extends Cubit<SalesStates> {
  SalesCubit() : super(InitSalesState());

  static SalesCubit get(context) => BlocProvider.of(context);

  List<SaleModel> sales = [];

  List<double> quantities = [];

  List<ProductModel>? productsByName = [];
  List<InvoiceModel> invoices = [];
  List<InvoiceModel> todayInvoices = [];
  List<InvoiceModel> dayInvoices = [];
  List<InvoiceModel> returnInvoices = [];
  List<String> dates = [];

  bool showWayInvoices = false;
  double rewardToday = 0;

  SearchProductUseCase searchProductUseCase = SearchProductUseCase(
    ProductsRepositoriesImplementation(),
  );
  SearchProductByNameUseCase searchProductByNameUseCase =
      SearchProductByNameUseCase(ProductsRepositoriesImplementation());

  Future<void> searchProduct(
    String id,
  ) async {
    try {
      ProductModel? product = await searchProductUseCase(id);
      if (product != null) {
        SalesScreen.price += product.sellingPrice;
        bool isThere = false;
        for (var element in sales) {
          if (element.productId == product.id) {
            element.quantity++;
            element.price = product.sellingPrice * element.quantity;
            isThere = true;
            break;
          }
        }
        if (!isThere) {
          SaleModel saleModel = SaleModel(
            productId: id,
            quantity: 1,
            price: product.sellingPrice,
            productName: product.name,
            piecePrice: product.sellingPrice,
            userName: 'hussein',
          );
          sales.insert(0, saleModel);
          quantities.insert(0, product.quantity);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    SalesScreen.searchController.clear();
    emit(AddProductToSalesState());
  }

  Future<void> addInvoice() async {
    if (sales.isNotEmpty) {
      InvoiceModel invoice = InvoiceModel(
        dateAndTime: DateTime.now().toString(),
        userName: 'userName',
        price: SalesScreen.price - SalesScreen.discount,
        customerId: 1,
        customerName: '',
        sales: sales,
        discount: SalesScreen.discount,
      );
      await SalesUseCases.addInvoiceUseCase(invoice);
      sales.clear();
      SalesScreen.price = 0;
      SalesScreen.discount = 0;
    }
    emit(AddInvoiceSuccessState());
  }

  removeItem(int index, double price) {
    SalesScreen.price -= price;
    sales.removeAt(index);
    emit(RemoveItemState());
  }

  Future<void> changeQuantity(int index, String op) async {
    final double price = sales[index].piecePrice;
    if (op == '+') {
      sales[index].quantity++;
      sales[index].price += price;
      SalesScreen.price += price;
    } else {
      if (sales[index].quantity != 1) {
        sales[index].quantity--;
        sales[index].price -= price;
        SalesScreen.price -= price;
      }
    }
    emit(ChangeQuantityState());
  }

  Future<void> getInvoices() async {
    todayInvoices.clear();
    invoices.clear();
    dates.clear();
    Invoices.total = 0;
    Invoices.reward = 0;
    print(Invoices.total);
    print(Invoices.reward);
    var data = await SalesUseCases.getInvoicesUseCase();
    invoices = data?.$1 ?? [];
    todayInvoices = data?.$2 ?? [];
    dates = data?.$3 ?? [];
    emit(GetInvoicesSuccessState());
  }

  Future<List<InvoiceModel>> getDayInvoices({required String date}) async {
    List<InvoiceModel> invoices =
        await SalesUseCases.getInvoicesDayUseCase(date);
    return invoices;
  }

  Future<void> showAllInvoices() async {
    showWayInvoices = !showWayInvoices;
    emit(ShowAllInvoicesState());
  }

  Future<void> makeDiscount() async {
    emit(MakeDiscountState());
  }

  Future<void> deleteInvoice(int id,context) async {
    bool? insure =await insureDialog(context, 'هل انت متاكد انك تريد حذف هذه الفاتورة');
    if(insure==true) {
      await SalesUseCases.deleteInvoiceUseCase(id);
      // invoices.remove(invoices.where((element) => element.id==id,).toList()[0]);
      await getInvoices();
      emit(DeleteInvoiceSuccessState());
    }
  }

  Future<void> searchByName(String name) async {
    productsByName = await searchProductByNameUseCase(name);
    emit(SearchByNameState());
  }

  Future<void> addReturnInvoice() async {
    if (sales.isNotEmpty) {
      InvoiceModel invoice = InvoiceModel(
        dateAndTime: DateTime.now().toString(),
        userName: 'userName',
        price: SalesScreen.price - SalesScreen.discount,
        customerId: 1,
        customerName: '',
        sales: sales,
        discount: SalesScreen.discount,
      );
      await SalesUseCases.addReturnInvoiceUseCase(invoice);
      sales.clear();
      SalesScreen.price = 0;
      SalesScreen.discount = 0;
    }
    emit(AddInvoiceSuccessState());
  }

  Future<void> getReturnInvoices() async {
    returnInvoices = (await SalesUseCases.getReturnInvoicesUseCase()) ?? [];
    emit(GetInvoicesSuccessState());
  }

  Future<void> sellPackageItem(int index) async {
    ProductModel? productModel =
        await searchProductUseCase(sales[index].productId);

    if (productModel!.packagePrice != null &&
        productModel.packageQuantity != null) {
      SalesScreen.price -= sales[index].price;
      sales[index].price = productModel.packagePrice!;
      sales[index].quantity = productModel.packageQuantity!.toDouble();

      SalesScreen.price += sales[index].price;
    }
    emit(ChangePriceAndQuantityState());
  }

  Future<void> generateInvoice(String price) async {
    final fontData = await rootBundle.load(
        "assets/fonts/Noto_Naskh_Arabic/NotoNaskhArabic-VariableFont_wght.ttf");
    final ttf = pw.Font.ttf(fontData);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl, // Set Right-to-Left
        theme: pw.ThemeData.withFont(base: ttf),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text(
                'INVOICE',
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold, font: ttf),
              ),
              pw.Text(
                'Alaith market',
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold, font: ttf),
              ),
              pw.SizedBox(height: 20),
              pw.ListView.separated(
                itemBuilder: (context, index) {
                  String name = sales[index].productName;
                  String quantity = sales[index].quantity.toString();
                  String price = sales[index].price.toString();
                  return pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.SizedBox(
                          width: 200,
                          child: pw.Text(name, style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Text(quantity, style: pw.TextStyle(font: ttf)),
                        pw.Text(price, style: pw.TextStyle(font: ttf)),
                      ]);
                },
                separatorBuilder: (context, index) =>
                    pw.Divider(height: 10, color: PdfColor.fromHex('#CCCCCC')),
                itemCount: sales.length,
              ),
              pw.SizedBox(
                height: 30,
              ),
              pw.Text('Total: $price', style: pw.TextStyle(font: ttf)),
              pw.Text('Date: ${DateTime.now().toString().substring(0, 16)}',
                  style: pw.TextStyle(font: ttf)),
              pw.Text('Discount: ${SalesScreen.discount}',
                  style: pw.TextStyle(font: ttf)),
            ],
          ),
        ),
      ),
    );
    List<Printer> printers=await Printing.listPrinters();
    Printer printer=printers.singleWhere((element) =>element.isDefault ,);
    await Printing.directPrintPdf(
      forceCustomPrintPaper: true,
      name: 'name.pdf',
      onLayout: (format) {
        return (pdf.save());
      },
      printer: printer,
    );
  }

  bool printing = false;

  void printInvoice(String price, context) async {
    if (!printing) {
      printing = true;
      await generateInvoice(price);
      SalesCubit.get(context).addInvoice();
      SalesScreen.discountController.clear();
      SalesScreen.focusNode.requestFocus();
    }
    printing = false;
  }
}
