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

import 'package:tania_farm/Calf/Treatment/CalfTreatmentDesc.dart';
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
import 'package:tania_farm/Calf/CalfBirth.dart';
import 'package:tania_farm/Calf/CalfDashboard.dart';
import 'package:tania_farm/Calf/Customer/CalfCustomer.dart';
import 'package:tania_farm/Calf/Expenses/CalfExpenses.dart';
import 'package:tania_farm/Calf/Expenses/CalfFeed.dart';
import 'package:tania_farm/Calf/Expenses/CalfLabour.dart';
import 'package:tania_farm/Calf/Expenses/CalfLabourPayment.dart';
import 'package:tania_farm/Calf/Expenses/CalfOthers.dart';
import 'package:tania_farm/Calf/Expenses/CalfOthersPayment.dart';
import 'package:tania_farm/Calf/Selling/CalfSelling.dart';
import 'package:tania_farm/Calf/Treatment/CalfTreatment.dart';
import 'package:tania_farm/Calf/Treatment/CalfTreatmentDoctor.dart';
import 'package:tania_farm/Cow/CowDashboard.dart';
import 'package:tania_farm/Cow/CowDelivary.dart';
import 'package:tania_farm/Cow/CowExpenses.dart';
import 'package:tania_farm/Cow/CowFeed.dart';
import 'package:tania_farm/Cow/CowLabour.dart';
import 'package:tania_farm/Cow/CowPurchase.dart';
import 'package:tania_farm/Cow/CowlabourPayment.dart';
import 'package:tania_farm/Cow/Feeding/CowFeeding.dart';
import 'package:tania_farm/Cow/HealthCare/HealthcareDashBoard.dart';
import 'package:tania_farm/Cow/HealthCare/HealthcareMedicine.dart';
import 'package:tania_farm/Cow/HealthCare/HealthcareVexine.dart';
import 'package:tania_farm/Cow/Treatment/CowDoctor.dart';
import 'package:tania_farm/Cow/Treatment/CowTreatment.dart';
import 'package:tania_farm/Cow/Treatment/Treatment.dart';
import 'package:tania_farm/Doctor/BeefFattening/DoctorBeef.dart';
import 'package:tania_farm/Doctor/Breeding/DoctorBreeding.dart';
import 'package:tania_farm/Doctor/Breeding/DoctorTreatment.dart';
import 'package:tania_farm/Doctor/Calf/DoctorCalf.dart';
import 'package:tania_farm/Doctor/Chicken/DoctorChicken.dart';
import 'package:tania_farm/Doctor/Dairy/DoctorDairy.dart';
import 'package:tania_farm/Doctor/Doctor.dart';
import 'package:tania_farm/Doctor/Duck/DoctorDuck.dart';
import 'package:tania_farm/Doctor/Goat/DoctorGoat.dart';
import 'package:tania_farm/Home.dart';
import 'package:tania_farm/Milk/Customers/DairyCustomer.dart';
import 'package:tania_farm/Milk/Customers/DairyCustomerInfo.dart';
import 'package:tania_farm/Milk/Expenses/Expenses.dart';
import 'package:tania_farm/Milk/Expenses/Feed.dart';
import 'package:tania_farm/Milk/Expenses/Labour.dart';
import 'package:tania_farm/Milk/Expenses/LabourPayment.dart';
import 'package:tania_farm/Milk/Expenses/Others.dart';
import 'package:tania_farm/Milk/Expenses/OthersPayment.dart';
import 'package:tania_farm/Milk/Feeding/Feeding.dart';
import 'package:tania_farm/Milk/Healthcare/DairyHealthcare.dart';
import 'package:tania_farm/Milk/Healthcare/DairyMedicines.dart';
import 'package:tania_farm/Milk/Healthcare/DairyVaccines.dart';
import 'package:tania_farm/Milk/MilkCustomer.dart';
import 'package:tania_farm/Milk/MilkDeshboard.dart';
import 'package:tania_farm/Milk/MilkLabour.dart';
import 'package:tania_farm/Milk/MilkLabourPayment.dart';
import 'package:tania_farm/Milk/MilkSelling.dart';
import 'package:tania_farm/Milk/Production/Production.dart';
import 'package:tania_farm/Milk/Purchase/Purchase.dart';
import 'package:tania_farm/Milk/Report/ExpensesReport.dart';
import 'package:tania_farm/Milk/Report/PurchaseReport.dart';
import 'package:tania_farm/Milk/Report/Report.dart';
import 'package:tania_farm/Milk/TotalMilkProd.dart';
import 'package:tania_farm/Milk/Treatment/DairyDoctors.dart';
import 'package:tania_farm/Milk/Treatment/DairyTreatment.dart';
import 'package:tania_farm/Milk/Treatment/DairyTreatmentList.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthWorm.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthWormEnvironment.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthWormExpenses.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthwormLabour.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthwormLabourPayment.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthwormOthers.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthwormOthersPayment.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthwormPurchase.dart';
import 'package:tania_farm/VermiCompost/Earthworm/EarthwormSellers.dart';
import 'package:tania_farm/VermiCompost/Earthworm/ProductionOfEartworm.dart';
import 'package:tania_farm/VermiCompost/Earthworm/SellsOfEarthWorm.dart';
import 'package:tania_farm/VermiCompost/Environment/VermiCompostEnvironment.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/CowdungPurchase.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/CowdungSellerList.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/LabourList.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/LabourPayment.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/MaterialsVermiCompost.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/OthersCostList.dart';
import 'package:tania_farm/VermiCompost/MaterialAndExpenses/OthersPayment.dart';
import 'package:tania_farm/VermiCompost/Production/VermiCompostProd.dart';
import 'package:tania_farm/VermiCompost/Production/vermicompost_shed.dard.dart';

import 'package:tania_farm/VermiCompost/Report/VermiCompostIncomeReport.dart';
import 'package:tania_farm/VermiCompost/Report/VermiCompostProductionReport.dart';
import 'package:tania_farm/VermiCompost/Report/VermiCompostProfitReport.dart';
import 'package:tania_farm/VermiCompost/Report/VermiCompostReport.dart';
import 'package:tania_farm/VermiCompost/Report/VermiCompostReportExpenses.dart';
import 'package:tania_farm/VermiCompost/Sells/VermiCompostSells.dart';
import 'package:tania_farm/VermiCompost/Sells/VermiCompostSellsButton.dart';
import 'package:tania_farm/VermiCompost/Sells/VermiSellsBuyerList.dart';
import 'package:tania_farm/VermiCompost/VermiCompostList.dart';
import 'package:flutter/material.dart';


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
        '/vermicompostlist': (context) => VermiCompostList(),
        '/cowdungPurchase' : (context) => CowdungPurchase(),
        '/cowdungPurchase' : (context) => CowdungPurchase(),
        '/labourList' : (context) => LabourList(),
        '/cowdungsellerList' : (context) =>CowdungSellerList(),
        '/earthworm' : (context) =>EarthwormComponent(),
        '/productionEarthWorm' : (context) =>ProductionEarthWorm(),
        '/sellsofEarthWorm' :(context) =>EarthWormSells(),
        '/vermicompostprod': (context) => VermiCompostProd(),
        '/vermicompostshed': (context) => VermiCompostShed(),
        '/vermicompostsells': (context) => VermiCompostSells(),
        '/labourPayment' : (context) => LabourPayment(),
        '/othersPayment' : (context) => OthersPayment(),
        '/othersCostList' :(context) => OthersList(),
        '/cowpurchase': (context) => CowdungPurchase(),
        '/vermicompostreport' : (context) =>VermiCompostReport(),
        '/vermicompostExpensesReport' : (context) =>VermiCompostExpensesReport(),
        '/vermiCompostProductionReport' : (context) => VermiCompostProductionReport(),
        '/vermiCompostIncomeReport' : (context) => VermiCompostIncomeReport(),
        '/vermiCompostProfitReport' : (context) =>VermiCompostprofitReport(),
        '/vermicompostenvironment': (context) => VermiCompostEnvironment(),
        '/materialsVermiCompost':(context)=>MaterialsVermiCompost(),
        '/earthwormExpenses' : (context) =>EarthwormExpenses(),
        '/earthwormEnvironment' : (context) =>EarthWormEnvironment(),
        '/earthwormsellers': (context) => EarthwormSellers(),
        '/earthwormpurchase': (context) => EarthwormPurchase(),
        '/earthwormlabour': (context) => EarthwormLabour(),
        '/earthwormlabourpayment': (context) => EarthwormLabourPayment(),
        '/earthwormothers': (context) => EarthwormOthers(),
        '/earthwormotherspayment': (context) => EarthwormOthersPayment(),
        '/vermiCompostSellsButton' : (context) => VermiCompostSellsButton(),
        '/vermiCompostSellBuyers' : (context) =>VermiSellsBuyersList(),

        //   Milk Section Start
        '/milkdashboard' : (context) => MilkDashboard(),

        //   Calf Section Start

        '/calfDashboard' : (context) => CalfDashboard(),


        '/calf_birth': (context) => CalfBirth(),
        '/calf_expenses': (context) => CalfExpenses(),
        '/calf_feed': (context) => CalfFeed(),
        '/calf_labour': (context) => CalfLabour(),
        '/calf_treatment_desc': (context) => CalfTreatmentDesc(),
        '/calf_labour_payment': (context) => CalfLabourPayment(),
        '/calf_others': (context) => CalfOthers(),
        '/calf_others_payment': (context) => CalfOthersPayment(),
        '/calf_treatment': (context) => CalfTreatment(),
        '/calf_treatment_doctor': (context) => CalfTreatmentDoctor(),
        '/calf_selling': (context) => CalfSelling(),
        '/calf_customer': (context) => CalfCustomer(),
        '/total_milk_prod': (context) => TotalMilkProd(),
        '/milk_selling': (context) => MilkSelling(),
        '/milk_customer': (context) => MilkCustomer(),
        '/milk_labour': (context) => MilkLabour(),
        '/milk_labour_payment': (context) => MilkLabourPayment(),

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

      //   Milk Section
        '/totalmilkproduction': (context) => TotalMilkProd(),
        '/milkselling': (context) => MilkSelling(),
        '/milklabour': (context) => MilkLabour(),
        '/milklaboursalary': (context) => MilkLabourPayment(),

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

        // Dairy Section Started
        '/dairy_production': (context) => DairyProduction(),
        '/dairy_purchase': (context) => DairyPurchase(),
        '/dairy_expenses': (context) => DairyExpenses(),
        '/dairyfeed': (context) => DairyFeed(),
        '/dairylabour': (context) => DairyLabour(),
        '/dairylabourpayment': (context) => DairyLabourPayment(),
        '/dairyothers': (context) => DairyOthers(),
        '/dairyotherspayment': (context) => DairyOthersPayment(),
        '/dairytreatmentlist': (context) => DairyTreatmentList(),
        '/dairy_doctors': (context) => DairyDoctors(),
        '/dairy_treatment': (context) => DairyTreatment(),
        '/dairy_customers': (context) => DairyCustomer(),
        '/dairy_customers_info': (context) => DairyCustomerInfo(),
        '/dairy_healthcare': (context) => DairyHealthcare(),
        '/dairy_medicines': (context) => DairyMedicines(),
        '/dairy_vaccines': (context) => DairyVaccines(),
        '/dairy_feeding': (context) => DairyFeeding(),
        '/dairy_reports': (context) => DairyReport(),
        '/dairy_expenses_report': (context) => DairyExpensesReport(),
        '/dairy_purchase_report': (context) => DairyPurchaseReport(),

      //   Calf Section

        //Auth
        '/': (context) => Login(),
        '/register': (context) => Signup(),

        //admin
        '/admin': (context) => Administrator(),
        '/approve_doctor': (context) => ApproveDoctor(),
        '/approved_doctor': (context) => ApprovedDoctor(),

        //doctor
        //doctor
        '/doctor': (context) => Doctor(),
        '/doctorbreeding': (context) => DoctorBreeding(),
        '/doctortreatment': (context) => DoctorTreatment(),
        '/doctorbeef': (context) => DoctorBeef(),
        '/doctordairy': (context) => DoctorDairy(),
        '/doctorduck': (context) => DoctorDuck(),
         '/doctorchicken': (context) => DoctorChicken(),
        '/doctorgoat': (context) => DoctorGoat(),
        '/doctorcalf': (context) => DoctorCalf(),


      },


    );
  }
}


