import 'package:flutter/material.dart';
import 'package:fseg_sousse/widgets/custom_card.dart';
import 'package:fseg_sousse/models/license.dart';
import 'package:fseg_sousse/models/master.dart';
import 'package:fseg_sousse/utilities/global_data.dart';
import 'package:fseg_sousse/views/subjects/subject_screen.dart';

class MasterList extends StatefulWidget {
  final List<Master> masterList;
  const MasterList({Key? key, required this.masterList}) : super(key: key);

  @override
  State<MasterList> createState() => _MasterListState();
}

class _MasterListState extends State<MasterList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.masterList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              GlobalData.setDegree('Masters');
              GlobalData.setDegreeLevel(widget.masterList[index].name);

              Navigator.pushNamed(context, SubjectScreen.id);
            },
            child: AppCard(model: widget.masterList[index]));
      },
    );
  }
}

class LicenseList extends StatefulWidget {
  final List<License> licenses;
  const LicenseList({Key? key, required this.licenses}) : super(key: key);

  @override
  State<LicenseList> createState() => _LicenseListState();
}

class _LicenseListState extends State<LicenseList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.licenses.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              GlobalData.setDegree('Licences');
              GlobalData.setDegreeLevel(widget.licenses[index].name);

              Navigator.pushNamed(context, SubjectScreen.id);
            },
            child: AppCard(model: widget.licenses[index]));
      },
    );
  }
}
