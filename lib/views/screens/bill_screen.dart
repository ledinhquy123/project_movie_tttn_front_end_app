import 'dart:ffi';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/transaction_controller.dart';
import 'package:app_movie/repo/payment.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_movie_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';

// ignore: must_be_immutable
class BillScreen extends StatefulWidget {
  dynamic movie;
  Map<String, dynamic> data;
  String comboName;
  dynamic combosQuantity;

  BillScreen({
    super.key,
    required this.movie,
    required this.data,
    required this.comboName,
    required this.combosQuantity
  });

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  dynamic date;
  List<dynamic> billData = [];
  List<dynamic> transactionData = [];
  dynamic user = SignInScreen.user;

  late Future<List<List<dynamic>>> fetchBill;
  String nameSeats = '';
  List<String> transaction_icons = [
    'assets/images/vnpay.png', 
    'assets/images/momo.png', 
    'assets/images/zalopay.png'
  ];

  Map<String, bool> selectTrans = {};

  // ZALO PAY
  String zpTransToken = "";
  String payResult = "";
  String payAmount = "10000";
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    date = HomeScreen.weekdayList.where((element) => element['name'] == widget.movie['weekday_name']).toList();
    date = date[0];

    fetchBill = fetchData();
  }

  Future<List<List<dynamic>>> fetchData() async {
    billData = await TransactionController.getBill(widget.data);
    if(billData.isEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Bạn chưa chọn ghế', Colors.red);
    }

    transactionData = await TransactionController.getTransactions();
    List<String> keys = transactionData.map((e) => e['id'].toString()).toList();
    List<bool> values = List.generate(transactionData.length, (index) => false);
    selectTrans = Map.fromIterables(keys, values);

    for(int i = 0; i < billData.length; i++){
      if(i != billData.length - 1) {
        nameSeats += '${billData[i]}, ';
      }else {
        nameSeats += '${billData[i]}';
      }
    }
    return [
      billData,
      transactionData
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain1, primaryMain2 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: FutureBuilder(
              future: fetchBill,
              builder: ((context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryMain1,
                    ),
                  );
                }else if(snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }else {
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height/16,
                          bottom: 24
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CINE AURA',
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 16), 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Chi tiết phim',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 16), 
                            CustomMovieSeatScreen(movie: widget.movie),
                                      
                            const SizedBox(height: 32), 
                            Container(
                              width: MediaQuery.of(context).size.width - 42,
                              height: 1,
                              color: outline,
                            ),
                            const SizedBox(height: 16), 
                                      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Chi tiết hoá đơn',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 16), 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Suất chiếu:',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  '${widget.movie['start_time']}, ${date['name']}, ${date['date']}',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phòng chiếu:',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  '${widget.movie['screen_name']}',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                                      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ghế:',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  nameSeats,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                        
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số lượng vé:',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  billData.length.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Người đặt:',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  user['name'],
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                        
                            const SizedBox(height: 16), 
                            Container(
                              width: MediaQuery.of(context).size.width - 42,
                              height: 1,
                              color: outline,
                            ),
                            const SizedBox(height: 16), 
                        
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng tiền:',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                                Text(
                                  '${billData.length * 60 + widget.combosQuantity * 45}.000đ',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                        
                            const SizedBox(height: 16), 
                            Container(
                              width: MediaQuery.of(context).size.width - 42,
                              height: 1,
                              color: outline,
                            ),
                            const SizedBox(height: 16), 
                        
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Phương thức thanh toán',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )
                                ),
                              ],
                            ),
                            const SizedBox(height: 16), 
                        
                            SizedBox(
                              height: 70,
                              child: ListView.builder(
                                itemCount: transactionData.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => customTransactions(
                                  transactionData[index], transaction_icons[index], false
                                )
                              ),
                            ),
                            const SizedBox(height: 32),

                            CustomButton(
                              text: 'Thanh toán',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                              ),
                              onTap: () {
                                String currentIndex = '#';
                                selectTrans.forEach((key, value) { 
                                  if(value == true) {
                                    currentIndex = key;
                                  }
                                });
                                if(currentIndex == '#') {
                                  showSnackbar(context, 'Hãy chọn hình thức thanh toán', Colors.red);
                                }else {
                                  dynamic transaction = transactionData.where((element) => element['id'].toString() == currentIndex).toList()[0];
                                  if(transaction['name'] == 'Zalo Pay') {
                                    _createOrderZalo('${billData.length * 60}000', currentIndex);
                                  }else {
                                    showSnackbar(context, 'Hình thức thanh toán đang bảo trì', Colors.red);
                                  }
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                
                      showButtonBack(context, primaryMain2, primaryMain1, Icons.arrow_back, 64, 0),
                    ]
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  _createOrderZalo(String value, String transactionTypeId) async {
    int amount = int.parse(value);
    if (amount < 1000 || amount > 1000000) {
      setState(() {
        zpTransToken = "Invalid Amount";
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryMain1,
            ),
          );
        }
      );
      var result = await createOrder(amount);
      if (result != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        zpTransToken = result.zptranstoken;
        setState(() {
          zpTransToken = result.zptranstoken;
          // showResult = true;
        });
        _payZalo(zpTransToken, transactionTypeId);
      }
    }
  }

  _payZalo(String zpToken, String transactionTypeId) async {
    FlutterZaloPaySdk.payOrder(zpToken: zpToken).then((event) {
      setState(() {
        switch (event) {
          case FlutterZaloPayStatus.cancelled:
            payResult = "User Huỷ Thanh Toán";
            showSnackbar(context, payResult, Colors.redAccent);
            break;
          case FlutterZaloPayStatus.success:
            payResult = "Thanh toán thành công";
            TransactionController.reservations(widget.data);

            final body = {
              'user_id': user['id'],
              'movie_id': widget.movie['movie_id'],
              'screen_name': widget.movie['screen_name'],
              'seats_name': nameSeats,
              'showdate': date['date'],
              'show_time': widget.movie['start_time'],
              'total_price': billData.length * 60 + widget.combosQuantity * 45,
              'transaction_type_id': transactionTypeId,
              'combos_name': widget.comboName
            };
            TransactionController.createTicket(body);

            showSnackbar(context, payResult, Colors.green);
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const HomeScreen())
            );
            break;
          case FlutterZaloPayStatus.failed:
            payResult = "Thanh toán thất bại";
            showSnackbar(context, payResult, Colors.red);
            break;
          default:
            payResult = "Thanh toán thất bại";
            showSnackbar(context, payResult, Colors.red);
            break;
        }
      });
    });
  }  

  Widget customTransactions(dynamic transaction, String icon, bool select) {
    return InkWell(
      onTap: () {
        setState(() {
          selectTrans.forEach((key, value) {
            selectTrans[key] = false;
            if(key == transaction['id'].toString()) {
              selectTrans[key] = !selectTrans[key]!;
            }
          });
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8)
          ),
          border: selectTrans[transaction['id'].toString()] == true 
          ? Border.all(
            width: 2,
            color: primaryMain1,
          )
          : null
        ),
    
        child: Row(
          children: [
            Image.asset(
              icon,
              fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['name'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: primaryMain2,
                    fontFamily: 'Poppins',
                  )
                ),
                Text(
                  'Miễn phí',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: outline,
                    fontFamily: 'Poppins',
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}