import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '/models/expense.dart';
import '../widgets/custom_text_form_field.dart';
import '/constants/utils.dart';
import '/controllers/expense_controller.dart';

class UpdateExpenseScreen extends StatefulWidget {
  final Expense expense;
  final String sheetId;
  final String expenseId;
  const UpdateExpenseScreen({
    super.key,
    required this.sheetId,
    required this.expenseId,
    required this.expense,
  });

  @override
  State<UpdateExpenseScreen> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  final expenseCon = Get.put(ExpenseController());

  // bool _isButtonPressable = false;
  bool _isDetailVisible = false;
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  String _name = "";
  String _price = "";
  String _quantity = "";
  String _detail = "";

  void _updateExpense() {
    var expenseData = Expense(
      name: _name,
      price: double.parse(_price),
      quantity: int.parse(_quantity),
      total: double.parse(
          (double.parse(_price) * int.parse(_quantity)).toString()),
      date: DateTime.parse(_date.toString()),
      detail: _detail.isEmpty ? "" : _detail,
    ).toMap();
    expenseCon.updateExpense(
      data: expenseData,
      sheetId: widget.sheetId,
      expenseId: widget.expenseId,
    );

    Get.back();
    Get.back();
    showSnackBar(context, "Expense updated");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2022, 5),
        lastDate: DateTime.now());
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  // void _checkButtonPressable() {
  //   if (_nameController.text.isNotEmpty &&
  //       _priceController.text.isNotEmpty &&
  //       _quantityController.text.isNotEmpty) {
  //     setState(() => _isButtonPressable = true);
  //   } else {
  //     setState(() => _isButtonPressable = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    _date = widget.expense.date;
    if (widget.expense.detail != "") {
      _isDetailVisible = true;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("Update Expense"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      DateFormat("d MMMM, y").format(_date),
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Detail "),
                      Switch(
                          value: _isDetailVisible,
                          onChanged: (bool val) {
                            setState(() {
                              _isDetailVisible = val;
                            });
                          }),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                label: "Name*",
                initialValue: widget.expense.name,
                onSaved: (val) => _name = val!,
                onChanged: (val) {},
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomTextFormField(
                      label: "Price*",
                      keyboardType: TextInputType.number,
                      initialValue:
                          widget.expense.price.toString().split(".").last == "0"
                              ? widget.expense.price.toString().split('.').first
                              : widget.expense.price.toString(),
                      onSaved: (val) => _price = val!,
                      onChanged: (val) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: CustomTextFormField(
                      keyboardType: TextInputType.number,
                      label: "Quantity*",
                      initialValue: widget.expense.quantity.toString(),
                      onSaved: (val) => _quantity = val!,
                      onChanged: (val) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _isDetailVisible
                  ? CustomTextFormField(
                      validator: false,
                      maxLines: 2,
                      label: "Details",
                      initialValue: widget.expense.detail,
                      onSaved: (val) => _detail = val!,
                    )
                  : const SizedBox(),
              _isDetailVisible ? const SizedBox(height: 10) : const SizedBox(),
              const SizedBox(height: 10),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    _formKey.currentState!.save();
                    _updateExpense();
                  },
                  child: const Text("Update Expense"),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
