import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/transaction_model.dart';
import '../theme/app_colors.dart';
import '../widgets/transaction_card.dart';

/// Screen 6: Digital passbook transaction ledger screen.
class TransactionsScreen extends StatefulWidget {
  final AppState appState;

  const TransactionsScreen({super.key, required this.appState});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _activeFilter = 'All'; // 'All', 'Completed', 'Pending'

  void _showReceipt(CollectionTransaction txn) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Digital Receipt 🧾',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Amount Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: txn.isCompleted
                      ? AppColors.primaryLight
                      : AppColors.statusPendingBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Text(
                      '₹${txn.amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: txn.isCompleted
                            ? AppColors.primaryDark
                            : AppColors.statusPending,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      txn.isCompleted
                        ? 'Payment Successfully Received'
                        : 'Payment Pending Recycler Verification',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _buildReceiptRow('Transaction ID', txn.id),
              _buildReceiptRow('E-Waste Lot ID', '#${txn.lotId}'),
              _buildReceiptRow('Items', txn.categorySummary),
              _buildReceiptRow('Total Weight', '${txn.weightKg} kg'),
              _buildReceiptRow('Authorized Recycler', txn.recyclerName),
              _buildReceiptRow('Payment Mode', txn.paymentMode),
              _buildReceiptRow('Date & Time', '${txn.date}, 02:45 PM'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Receipt downloaded successfully!'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('Download Receipt (PDF)'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textMedium,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CollectionTransaction> list = widget.appState.transactions;
    if (_activeFilter == 'Completed') {
      list = list.where((t) => t.isCompleted).toList();
    } else if (_activeFilter == 'Pending') {
      list = list.where((t) => !t.isCompleted).toList();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mere Transactions'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Simple Filter Chips: All, Completed, Pending
              Row(
                children: [
                  _buildFilterTab('All (Sabhi)'),
                  const SizedBox(width: 8),
                  _buildFilterTab('Completed'),
                  const SizedBox(width: 8),
                  _buildFilterTab('Pending'),
                ],
              ),

              const SizedBox(height: 18),

              // Total earnings banner for the selected view
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kul Transactions: ${list.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      'Total: ₹${list.fold<double>(0, (sum, item) => sum + item.amount).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Transaction List
              if (list.isEmpty) ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'Koi transaction nahi mila',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                ...list.map((txn) {
                  return TransactionCard(
                    transaction: txn,
                    onTap: () => _showReceipt(txn),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label) {
    final filterKey = label.startsWith('All') ? 'All' : label;
    final isSelected = _activeFilter == filterKey;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeFilter = filterKey),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
