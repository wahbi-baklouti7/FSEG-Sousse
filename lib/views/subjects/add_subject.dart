// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/viewModel/subject/add_subject_view_model.dart';
import 'package:fseg_sousse/views/subjects/widgets/subject_local_widgets.dart';
import 'package:fseg_sousse/widgets/default_text_form.dart';
import 'package:fseg_sousse/widgets/no_internet.dart';
import 'package:provider/provider.dart';

class AddSubject extends StatelessWidget {
  static const String id = " Add Subject";
  String? _subjectTittle;
  final _formKey = GlobalKey<FormState>();

  AddSubject({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AddSubjectViewModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: NetworkSensitiveWidget(
          child: Padding(
            padding: AppSize.lrtpPadding,
            child: Form(
              key: _formKey,
              child: Column(children: [
                Row(children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]),
                const Spacer(),
                AppTextForm(
                    lableText: "Subject Title",
                    hintText: "Subject Title",
                    onSaved: (value) {
                      _subjectTittle = value;
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Subject Title";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                const SemesterField(),
                const SizedBox(
                  height: 16,
                ),
                Selector<AddSubjectViewModel, int?>(
                    selector: (context, addSubject) =>
                        addSubject.getSelectedSemester,
                    builder: (context, data, _) {
                      return AppIconButton(
                        textButton: "ADD",
                        onPressed: data != null
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  _provider.addSubject(
                                      subject: _subjectTittle!.trim(),
                                      context: context);
                                }
                              }
                            : null,
                        icon: Icons.add,
                      );
                    }),
                const Spacer()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
