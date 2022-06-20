import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/constants/utils.dart';
import '/controllers/expense_controller.dart';
import '/models/expense.dart';
import '../widgets/custom_text_form_field.dart';

class AddExpenseScreen extends StatefulWidget {
  final String sheetId;
  const AddExpenseScreen({
    super.key,
    required this.sheetId,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final expenseCon = Get.put(ExpenseController());

  bool _isButtonPressable = false;
  bool _isDetailVisible = false;
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController(text: 1.toString());
  final _detailController = TextEditingController();
  void _addExpense() {
    var expenseData = Expense(
      name: _nameController.text,
      price: double.parse(_priceController.text),
      quantity: int.parse(_quantityController.text),
      total: double.parse((double.parse(_priceController.text) *
              int.parse(_quantityController.text))
          .toString()),
      date: DateTime.parse(_date.toString()),
      detail: _detailController.text.isEmpty ? "" : _detailController.text,
    ).toMap();
    //firebase add sheet
    expenseCon.addExpense(
      data: expenseData,
      sheetId: widget.sheetId,
    );
   
    Get.back();
    showSnackBar(context, "Expense created");
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

  void _checkButtonPressable() {
    if (_nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      setState(() => _isButtonPressable = true);
    } else {
      setState(() => _isButtonPressable = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("Add Expense"),
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
                      DateFormat.yMMMd().format(_date),
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
                controller: _nameController,
                onChanged: (val) {
                  _checkButtonPressable();
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomTextFormField(
                      label: "Price*",
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      onChanged: (val) {
                        _checkButtonPressable();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: CustomTextFormField(
                      keyboardType: TextInputType.number,
                      label: "Quantity*",
                      controller: _quantityController,
                      onChanged: (val) {
                        _checkButtonPressable();
                      },
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
                      controller: _detailController,
                    )
                  : const SizedBox(),
              _isDetailVisible ? const SizedBox(height: 10) : const SizedBox(),
              const SizedBox(height: 10),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonPressable
                      ? () {
                          _formKey.currentState!.validate();
                          _addExpense();
                        }
                      : null,
                  child: const Text("Add Expense"),
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
