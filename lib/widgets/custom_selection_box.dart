import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/kyc/tattoos_guide.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';

class CustomSelectionTextField extends StatefulWidget {
  const CustomSelectionTextField({super.key});

  @override
  State<CustomSelectionTextField> createState() => _CustomSelectionTextFieldState();
}

class _CustomSelectionTextFieldState extends State<CustomSelectionTextField> {
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController genotypeController = TextEditingController();
  TextEditingController donatedBloodController = TextEditingController();
   TextEditingController lastTimeController = TextEditingController();
  TextEditingController tattoosController = TextEditingController();

  List<String> booldGroup = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  List<String> genotype = ['AA','AS','AC','SS','SC'];
  List<String> donateBlood = ['YES','NO'];
  List<String> lastTime = ['AA','AS','AC','SS','SC'];
  List<String> tattoos = ['YES','NO'];

  bool monthsDisplay = false;
  bool daysDisplay = false;
  bool yearsDisplay = false;
  bool lastTimeDisplay = false;
  bool tattoosDisplay = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: content());
  }

  Widget content(){
    return  Padding(
      padding: EdgeInsets.all(2.0.wp),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text('What is your blood group?'),
            inputField('booldGroup',bloodGroupController),
            daysDisplay? selectionField('booldGroup',bloodGroupController):const SizedBox(),
                
            const Text('What is your Genotype?'),
            inputField('genotype',genotypeController),
            monthsDisplay? selectionField('genotype',genotypeController):const SizedBox(),
            
            const Text('Have you ever donated blood?'),
            inputField('donateBlood',donatedBloodController),
            yearsDisplay? selectionField('donateBlood', donatedBloodController):const SizedBox(),  
                 
            const Text('When was the last time you donated blood?'),
            inputField('lastTime',lastTimeController),
            lastTimeDisplay? selectionField('lastTime', lastTimeController):const SizedBox(),  
                
            const Text('Do you have any Tattoos?'),
            inputField('tattoos',tattoosController),
            tattoosDisplay? selectionField('tattoos', tattoosController):const SizedBox(),  
               
             
            SizedBox(height: 4.0.hp,),
            Center(
              child: CustomButton(
                text: 'NEXT', 
                width: 40.0.wp, 
                height: 5.0.hp, 
                onTapHandler: (){
                  Get.to(TattoosScreen());
                }, 
                fontSize: 15.0.sp, 
                fontColor: Colors.white, 
                fontWeight: FontWeight.bold, 
                borderRadius: 10, backgroundColor: AppStyles.bgBlue),
            ),
            
          ]
      ),
    );
  }

  Widget inputField(String type, TextEditingController controller){
    return Container(
            height:50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
              color:Colors.grey
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: (){
                    
                      setState(() {
                        switch (type) {
                      case 'booldGroup':
                        daysDisplay=!daysDisplay;
                        break;
                      case 'genotype':
                        monthsDisplay=!monthsDisplay;
                        break;
                      case 'donateBlood': 
                        yearsDisplay=!yearsDisplay;
                        break;
                      case 'lastTime': 
                        lastTimeDisplay=!lastTimeDisplay;
                        break;
                      case 'tattoos': 
                        tattoosDisplay=!tattoosDisplay;
                        break;
                    }
                      });
                  },
                  child: const Icon(
                    Icons.arrow_downward
                    ),
                )),

            ),
          );
  } 
  Widget selectionField(type, TextEditingController controller){
    return Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.white,
                boxShadow: [  
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0,3),
                  )
                ]
              ),
              child: ListView.builder(
                itemCount: type=='booldGroup'?booldGroup.length:type=='lastTime'?lastTime.length:type=='genotype'?genotype.length:type=='tattoos'?tattoos.length:donateBlood.length,
              itemBuilder: ((context,index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      // controller.text = (index+1).toString();
                      switch (type) {
                        case 'booldGroup':
                          controller.text=genotype[index];
                          break;
                        case 'genotype':
                          controller.text=booldGroup[index];
                          break;
                        case 'donateBlood':
                          controller.text=donateBlood[index];
                          break;
                        case 'lastTime':
                          controller.text=lastTime[index];
                          break;
                        case 'tattoos':
                          controller.text=tattoos[index];
                          break;
                      }
                    });
                    
                  },
                  child: ListTile(
                    title: Text(type=='booldGroup'?booldGroup[index]:type=='genotype'?booldGroup[index]:type=='lastTime'?lastTime[index]:type=='tattoos'?tattoos[index]:donateBlood[index],),
                  ),
                );
              }),
          
            ),
    );
  }
}

