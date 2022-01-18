import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/models/menuChoiceModel.dart';
import 'package:fseg_sousse/views/home/widgets/homeLocalWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  static const String id = "Home";
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: AppSize.APP_PADDING,
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("FSEGS",
                style: GoogleFonts.roboto(
                    fontSize: 40, fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Menu", style: GoogleFonts.roboto(fontSize: 24))],
          ),
          SizedBox(
            height: 48,
          ),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemCount: menuChoices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, menuChoices[index].title,
                          arguments: menuChoices[index]);
                    },
                    child: SelectedCard(
                      choice: menuChoices[index],
                    ),
                  );
                }),
          )
        ]),
      ),
    ));
  }
}


