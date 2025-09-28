import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/firestore_expense_provider.dart';
import '../../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final bool isIncome;
  
  const AddExpenseScreen({super.key, this.isIncome = false});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Alimentación';
  DateTime _selectedDate = DateTime.now();
  late bool _isIncome;

  static const List<String> _expenseCategories = [
    'Alimentación',
    'Transporte',
    'Entretenimiento',
    'Salud',
    'Educación',
    'Ropa',
    'Hogar',
    'Otros',
  ];

  static const List<String> _incomeCategories = [
    'Salario',
    'Freelance',
    'Inversión',
    'Venta',
    'Bonificación',
    'Otros',
  ];

  @override
  void initState() {
    super.initState();
    _isIncome = widget.isIncome;
    // Establecer categoría por defecto según el tipo
    if (_isIncome) {
      _selectedCategory = _incomeCategories.first;
    } else {
      _selectedCategory = _expenseCategories.first;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isIncome ? 'Agregar Ingreso' : 'Agregar Gasto'),
        backgroundColor: _isIncome ? Colors.green : const Color(0xFF667eea),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add_circle,
                          size: 64,
                          color: Color(0xFF667eea),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Nuevo Gasto',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF667eea),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SwitchListTile(
                          title: const Text('Es un ingreso'),
                          subtitle: const Text(
                            'Marca si es dinero que recibes',
                          ),
                          value: _isIncome,
                          onChanged: (value) {
                            setState(() {
                              _isIncome = value;
                              // Actualizar categoría por defecto según el tipo
                              if (_isIncome) {
                                _selectedCategory = _incomeCategories.first;
                              } else {
                                _selectedCategory = _expenseCategories.first;
                              }
                            });
                          },
                          activeThumbColor: const Color(0xFF667eea),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Título',
                            prefixIcon: const Icon(Icons.title),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un título';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Cantidad',
                            prefixIcon: const Icon(Icons.attach_money),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa una cantidad';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Por favor ingresa un número válido';
                            }
                            if (double.parse(value) <= 0) {
                              return 'La cantidad debe ser mayor a 0';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Categoría',
                            prefixIcon: Icon(
                              _isIncome ? Icons.trending_up : Icons.trending_down,
                              color: _isIncome ? Colors.green : const Color(0xFF667eea),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: (_isIncome ? _incomeCategories : _expenseCategories).map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Fecha',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Descripción (opcional)',
                            prefixIcon: const Icon(Icons.description),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Consumer<FirestoreExpenseProvider>(
                          builder: (context, expenseProvider, child) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: expenseProvider.isLoading
                                    ? null
                                    : () => _handleSubmit(expenseProvider),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isIncome ? Colors.green : const Color(0xFF667eea),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: expenseProvider.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        _isIncome ? 'Agregar Ingreso' : 'Agregar Gasto',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _handleSubmit(FirestoreExpenseProvider expenseProvider) async {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final expense = Expense(
        title: _titleController.text.trim(),
        amount: _isIncome ? amount : -amount,
        category: _selectedCategory,
        date: _selectedDate,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        userId: FirebaseAuth.instance.currentUser?.uid ?? 'anonymous',
      );

      final success = await expenseProvider.addExpense(expense);

      if (mounted) {
        if (success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gasto agregado exitosamente a Firestore'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: ${expenseProvider.error ?? 'Error desconocido'}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
