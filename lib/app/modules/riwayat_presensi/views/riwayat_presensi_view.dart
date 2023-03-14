import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/controller/api_controller.dart';
import 'package:project_tugas_akhir/app/data/models/allscanlogmodel.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:project_tugas_akhir/app/utils/btnDefault.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart' as rspnsvlue;
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/appBar.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final controller = Get.put(RiwayatPresensiController());
    final apiC = Get.put(APIController());
    final dataScanlog = DataScanlog();
    return Scaffold(
      backgroundColor: light,
      drawer: const NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: light,
          automaticallyImplyLeading: false,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: null,
          title: Padding(
            padding: EdgeInsets.only(
              left: 1.5.w,
              top: 26,
            ),
            child: Builder(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                      icon: FaIcon(
                        FontAwesomeIcons.bars,
                        color: Blue1,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 1.5.w,
                    ),
                    child: IconButton(
                      color: Blue1,
                      onPressed: () => authC.logout(),
                      icon: Icon(IconlyLight.logout),
                      iconSize: 30,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w, bottom: 8.h),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riwayat Presensi Semua Pegawai',
                  style: getTextHeader(context),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  children: [
                    Text(
                      'November 2022',
                      style: getTextSubHeader(context),
                    ),
                    Text(
                      ' / ',
                      style: getTextSubHeader(context),
                    ),
                    Text(
                      'Februari 2023',
                      style: getTextSubHeader(context),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 1.8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btnDefaultIcon1(13.w, Blue1, IconlyLight.swap, Yellow1,
                      "Refresh Data", getTextBtnAction(context), () {
                    apiC.getAllPresenceData(context);
                  }),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  textButton1(IconlyLight.calendar, Blue1, "Filter Tanggal",
                      getTextBtn(context), () {}),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(color: Blue1.withOpacity(0.2)),
                width: 90.w,
                height: 60.h,
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 2000,
                    columns: [
                      DataColumn2(
                        label: Text('Column A'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Column B'),
                      ),
                      DataColumn(
                        label: Text('Column C'),
                      ),
                      DataColumn(
                        label: Text('Column D'),
                      ),
                      DataColumn(
                        label: Text('Column E'),
                      ),
                      DataColumn(
                        label: Text('Column F'),
                      ),
                      DataColumn(
                        label: Text('Column NUMBERS'),
                        numeric: true,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        100,
                        (index) => DataRow(cells: [
                              DataCell(Text('A' * (10 - index % 10))),
                              DataCell(Text('B' * (10 - (index + 5) % 10))),
                              DataCell(Text('C' * (15 - (index + 5) % 10))),
                              DataCell(Text('D' * (15 - (index + 10) % 10))),
                              DataCell(Text('E' * (15 - (index + 15) % 10))),
                              DataCell(Text('F' * (15 - (index + 20) % 10))),
                              DataCell(Text(((index + 0.1) * 25.4).toString()))
                            ]))),

                //SingleChildScrollView(
                // child: PaginatedDataTable2(
                //   columns: [
                //     DataColumn(label: Text("PIN")),
                //     DataColumn(label: Text('Scan Date'))
                //   ],
                //   source: dataScanlog,
                //   rowsPerPage: controller.rowPerPage.value,
                //   onRowsPerPageChanged: (index) {
                //     controller.rowPerPage.value = index!;
                //   },
                // ),
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
