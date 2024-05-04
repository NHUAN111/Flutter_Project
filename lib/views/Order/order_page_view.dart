import 'package:flutter/material.dart';
import 'package:project_specialized_1/views/Order/order_page_canceled.dart';
import 'package:project_specialized_1/views/Order/order_page_completed.dart';
import 'package:project_specialized_1/views/Order/order_page_delivery.dart';
import 'package:project_specialized_1/views/Order/order_page_process.dart';

class OrderViews extends StatefulWidget {
  const OrderViews({Key? key}) : super(key: key);

  @override
  _OrderViewsState createState() => _OrderViewsState();
}

class _OrderViewsState extends State<OrderViews> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ProcessingPage(),
    const DeliveringPage(),
    const CompletedPage(),
    const CanceledPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn Hàng Của Bạn'),
        centerTitle: true, // Căn giữa tiêu đề
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            color: Colors.blue,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.pending_actions),
                  label: 'Đang xử lý',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_shipping),
                  label: 'Đang giao',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: 'Hoàn thành',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cancel),
                  label: 'Đã hủy',
                ),
              ],
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class ProcessingPage extends StatelessWidget {
  const ProcessingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrdersProcessPage(),
    );
  }
}

class DeliveringPage extends StatelessWidget {
  const DeliveringPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrdersDeliveryPage(),
    );
  }
}

class CompletedPage extends StatelessWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrdersCompletedPage(),
    );
  }
}

class CanceledPage extends StatelessWidget {
  const CanceledPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrdersCanceledPage(),
    );
  }
}
