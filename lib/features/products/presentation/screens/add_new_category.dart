import 'package:flutter/material.dart';
import 'package:market/features/products/domain/entities/category.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/global/widgets/default_button.dart';
import '../../../../global/widgets/default_text_form_field.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    TextEditingController nameCategoryController = TextEditingController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: SizedBox(
                width: width / 2,
                child: DefaultFormField(
                  controller: nameCategoryController,
                  hintText: 'اسم الصنف',
                ),
              ),
            ),
            DefaultButton(
              onPressed: () async {
                await ProductsCubit.get(context).addCategory(
                  CategoryEntity(
                    id: 0,
                    name: nameCategoryController.text,
                  ),
                  context
                );

              },
              textBtn: 'اضافة',
            ),
          ],
        ),
      ),
    );
  }
}
