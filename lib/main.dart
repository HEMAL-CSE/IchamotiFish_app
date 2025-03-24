import 'package:tania_farm/Administrator/Administrator.dart';
import 'package:tania_farm/Administrator/ApproveDoctor.dart';
import 'package:tania_farm/Administrator/ApprovedDoctor.dart';
import 'package:tania_farm/Auth/login.dart';
import 'package:tania_farm/Auth/signup.dart';
import 'package:tania_farm/Beeffatteing/BeefFattening.dart';
import 'package:tania_farm/Beeffatteing/BeefFeeding/BeefFeeding.dart';
import 'package:tania_farm/Beeffatteing/CattlePurchase/BeefCattlePurchase.dart';
import 'package:tania_farm/Beeffatteing/Customers/BeefCustomer.dart';
import 'package:tania_farm/Beeffatteing/Customers/BeefCustomerInfo.dart';
import 'package:tania_farm/Beeffatteing/Expenses/BeefFatteningExpenses.dart';
import 'package:tania_farm/Beeffatteing/Expenses/BeefFatteningFeed.dart';
import 'package:tania_farm/Beeffatteing/Expenses/BeefFatteningLabour.dart';
import 'package:tania_farm/Beeffatteing/Expenses/BeefFatteningOthers.dart';
import 'package:tania_farm/Beeffatteing/Expenses/BeefFatteningOthersPayment.dart';
import 'package:tania_farm/Beeffatteing/Expenses/BeeffatteningLabourPayment.dart';
import 'package:tania_farm/Beeffatteing/Healthcare/BeefHealthcare.dart';
import 'package:tania_farm/Beeffatteing/Healthcare/BeefMedicines.dart';
import 'package:tania_farm/Beeffatteing/Healthcare/BeefVaccines.dart';
import 'package:tania_farm/Beeffatteing/Report/BeefFatteningreport.dart';
import 'package:tania_farm/Beeffatteing/Report/BeefReportExpenses.dart';
import 'package:tania_farm/Beeffatteing/Report/BeefReportIncome.dart';
import 'package:tania_farm/Beeffatteing/Report/BeefReportProduction.dart';
import 'package:tania_farm/Beeffatteing/Report/BeefReportProfit.dart';
import 'package:tania_farm/Beeffatteing/Slaughtering/BeefSlaughtering.dart';
import 'package:tania_farm/Beeffatteing/Treatment/BeefFatteningTreatmentDesc.dart';
import 'package:tania_farm/Beeffatteing/Treatment/BeefFatteningTreatmentDoctor.dart';
import 'package:tania_farm/Beeffatteing/Treatment/BeefTreatment.dart';

import 'package:tania_farm/Cow/CowDashboard.dart';
import 'package:tania_farm/Cow/CowDelivary.dart';
import 'package:tania_farm/Cow/CowExpenses.dart';
import 'package:tania_farm/Cow/CowFeed.dart';
import 'package:tania_farm/Cow/CowLabour.dart';
import 'package:tania_farm/Cow/CowOthers.dart';
import 'package:tania_farm/Cow/CowOthersPayment.dart';
import 'package:tania_farm/Cow/CowPurchase.dart';
import 'package:tania_farm/Cow/CowSellingInfo.dart';
import 'package:tania_farm/Cow/CowlabourPayment.dart';
import 'package:tania_farm/Cow/CowlabourPayment.dart';
import 'package:tania_farm/Cow/Feeding/CowFeeding.dart';
import 'package:tania_farm/Cow/HealthCare/HealthcareDashBoard.dart';
import 'package:tania_farm/Cow/HealthCare/HealthcareMedicine.dart';
import 'package:tania_farm/Cow/HealthCare/HealthcareVexine.dart';
import 'package:tania_farm/Cow/Treatment/CowDoctor.dart';
import 'package:tania_farm/Cow/Treatment/CowTreatment.dart';
import 'package:tania_farm/Cow/Treatment/Treatment.dart';

import 'package:tania_farm/Home.dart';
import 'package:tania_farm/Ichamoti/IchamotiExpenses/FoodExpenses.dart';
import 'package:tania_farm/Ichamoti/IchamotiExpenses/IchamotiExpenses.dart';
import 'package:tania_farm/Ichamoti/IchamotiExpenses/Labourlist.dart';
import 'package:tania_farm/Ichamoti/OthersFeatures.dart';
import 'package:tania_farm/Ichamoti/fishsells.dart';
import 'package:tania_farm/Ichamoti/ichamotidashboard.dart';
import 'package:tania_farm/Ichamoti/ichamotifishinfo.dart';
import 'package:tania_farm/Ichamoti/pondinfo.dart';

import 'package:flutter/material.dart';
import 'package:tania_farm/Ichamoti/production.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),


        '/beeffattening' : (context) => BeefFattening(),


        // Cow/ Breeding:
        '/cowdashboard' : (context) => CowDashboard(),
        
        '/cowpurchase': (context) => CowPurchase(),
        '/cowdelivary': (context) => DelivaryReport(),
        '/cowexpenses': (context) => BreedingExpenses(),
        '/cowfeed' : (context) => BreedingFeed(),
        '/cowlabour' : (context) => BreedingLabour(),
        '/cowlabourpayment': (context) => BreedingLabourPayment(),
        '/cowOthers': (context) => BreedingOthers(),
        '/cowOtherPayment' : (context) => BreedingOthersPayment(),

      //   Treatment Section
        '/treatmantdashboard' : (context) => TreatmentDashboard(),
        '/CowDoctor' : (context) => CowDoctor(),
        '/cowtreatment' : (context) => BreedingTreatment(),
        '/cowSelling': (context) => SellingInfo(),

      //   Cow HealthCare Section
        '/cowheathcare': (context) => CowHealthcare(),
        '/cowVaccines': (context) => BreedingVaccines(),
        '/cowMedicine': (context) => BreedingMedicines(),
        '/cowFeeding': (context) => BreedingFeeding(),


        //beef
        '/beefCattlePurchase' : (context) => BeefCattlePurchase(),
        '/beefCustomer' : (context) => BeefCustomer(),
        '/beefCustomerInfo' : (context) =>BeefCustomerInfo(),
        '/beefSlaughtering' : (context) =>BeefSlaughtering(),
        '/beefFatteningExpenses' : (context) =>BeefFatteningExpenses(),
        '/beefTreatment' : (context) =>Beeftreatment(),
        '/beefFatteningDoctor': (context) => BeefFatteningTreatmentDoctor(),
        '/beefFatteningTreatmentDesc': (context) => BeefFatteningTreatmentDesc(),
        '/beefFatteningFeed': (context) => BeefFatteningFeed(),
        '/beefFatteningLabour': (context) => BeefFatteningLabour(),
        '/beefFatteningPayment' : (context) => BeefFatteningLabourPayment(),
        '/beefFatteningOthers' : (context) => BeefFatteningOthers(),
        '/beefFatteningOthersPayment': (context) =>BeefFatteningOtherspayment(),
        '/beeffatteningReport' : (context) =>BeefFatteningReport(),
        '/beefExpensesReport': (context) => BeefExpensesReport(),
        '/beefProfitReport': (context) => BeefProfitReport(),
        '/beefProductionReport': (context) =>BeefProductionReport(),
        '/beefIncomeReport' : (context) =>BeefIncomeReport(),
        '/beef_feeding': (context) => BeefFeeding(),
        '/beef_healthcare': (context) => BeefHealthcare(),
        '/beef_vaccines': (context) => BeefVaccines(),
        '/beef_medicines': (context) => BeefMedicines(),



      //   Calf Section

        //Auth
        '/': (context) => Login(),
        '/register': (context) => Signup(),

        //admin
        '/admin': (context) => Administrator(),
        '/approve_doctor': (context) => ApproveDoctor(),
        '/approved_doctor': (context) => ApprovedDoctor(),


        // IchaMoti Pond Section
        '/ichamotidashboard': (context) => Ichamotidashboard(),
        '/ichamotiponds': (context) => IchamotiPond(),
        '/ichamotifishinfo': (context) => Ichamotifishinfo(),
        '/fishproduction': (context) => FishProduction(),
        '/fishsells': (context) => Fishsells(),
        '/othersfeatures': (context) => othersFeatures(),
        '/ichamotiexpenses': (context) => IchamotiExpenses(),
        '/foodexpenses': (context) => Foodexpenses(),

        '/expenseslabourlist': (context) => ExpensesLabourList(),

      },


    );
  }
}


