import 'package:flutter/material.dart';
import 'package:healthsphere/components/main_doctor_card.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/doctor.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (supabase.auth.currentUser == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final res = await supabase.from("doctors").select() as List;
    List<Doctor> temp = [];
    for (var ele in res) {
      final res2 = await supabase
          .from("hospitals")
          .select()
          .eq("id", ele["hospital"])
          .limit(1)
          .single();
      ele.addAll({"hospitalName": res2["name"]});

      temp.add(Doctor.fromMapFull(ele));
    }
    setState(() {
      data.addAll(temp);
      isLoading = false;
    });
  }

  bool isLoading = true;
  List<Doctor> data = [];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top * 0.2,
        right: 10,
        left: 10,
      ),
      child: ListView.builder(
        itemCount: data.length + 1,
        itemBuilder: (context, index) => index == 0
            ? Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  "Doctors",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )
            : MainDoctorCard(
                doctor: data[index - 1],
              ),
      ),
    );
  }
}
