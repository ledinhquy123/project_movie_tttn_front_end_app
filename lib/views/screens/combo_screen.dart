import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/services/combo_api.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/views/screens/bill_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComboScreen extends StatefulWidget {
  dynamic movie;
  Map<String, dynamic> data;

  ComboScreen({
    super.key,
    required this.data,
    required this.movie
  });

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends State<ComboScreen> {
  List<dynamic> dataCombos = [];
  Map<dynamic, dynamic> stateCombos = {};

  late Future<List<dynamic>> getCombos;

  Future<List<dynamic>> fetchGetCombos() async {
    dataCombos = await ComBoApi.getCombos();
    for(var combo in dataCombos) {
      stateCombos[combo['id']] = 0;
    }
    return dataCombos;
  }

  @override
  void initState() {
    super.initState();
    getCombos = fetchGetCombos();
  }

  @override
  Widget build(BuildContext context) {
     return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain1, primaryMain2 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Stack(
              children: [
                FutureBuilder(
                  future: getCombos, 
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryMain1,
                        ),
                      );
                    }else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error ${snapshot.error}'),
                      );
                    }else {
                      return Padding(
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
                            ListView.builder(
                              itemCount: dataCombos.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0)
                                  )
                                ),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: customCombo(dataCombos[index])
                              )
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Nếu không có nhu cầu mua(quý khách chỉ cần không chọn combo)',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16.0),

                            CustomButton(
                              text: 'Tiếp tục',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                              ),
                              onTap: () {
                                String combos = '';
                                dynamic combosQuantity = 0;
                                stateCombos.forEach((key, value) {
                                  if(value != 0) {
                                    combosQuantity += value;
                                    dynamic temp = dataCombos.where((element) => element['id'] == key).toList();
                                    combos += '(${temp[0]['name']})x$value, ';
                                  }
                                });
                                if(combos != '') {
                                  combos = combos.substring(0, combos.length - 2);
                                } else {
                                  combos = 'Không có combos';
                                }
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => BillScreen(
                                    movie: widget.movie,
                                    data: widget.data,
                                    comboName: combos,
                                    combosQuantity: combosQuantity,
                                  ))
                                );
                              }
                            )
                          ],
                        ),
                      );
                    }
                  }
                ),
                showButtonBack(context, primaryMain2, primaryMain1, Icons.arrow_back, 64, 0),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget customCombo(dynamic combo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              combo['image_path'],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Ảnh đã được tải thành công, hiển thị nó
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryMain1,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  combo['name'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  )
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 4.0,
                ),

                Text(
                  '${combo['price']}.000',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  )
                ),
              ],
            )
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        stateCombos[combo['id']]++;
                      });
                    },
                    child: const Icon(Icons.add_circle)
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if(stateCombos[combo['id']] != 0) stateCombos[combo['id']]--;
                      });
                    },
                    child: const Icon( Icons.remove_circle)
                  )
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.black12,
                radius: 10,
                child: Text(
                  stateCombos[combo['id']].toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  )  
                )
              )
            ],
          )
        ),
      ],
    );
  }
}