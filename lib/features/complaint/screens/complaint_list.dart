import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc/theme/colors.dart';
import '../../../bloc/complaint/complaint_bloc.dart';
import '../../../constants/assets_constants.dart';
import '../widgets/complaint_widget.dart';

class ComplaintList extends StatelessWidget {
  const ComplaintList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 85,
        ),
        child: FloatingActionButton.extended(
          label: Text(
            "Register Complaint",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
          ),
          icon: SvgPicture.asset(AssetsConstants.edit),
          onPressed: () {
            context.push('/complaint_register');
          },
          backgroundColor: AppColors.greenBlue,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'Complaints',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      body: BlocBuilder<ComplaintBloc, ComplaintState>(
        builder: (context, state) {
          if (state is ComplaintLoading || state is ComplaintInitial) {
            const CircularProgressIndicator();
          } else if (state is ComplaintLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ComplaintWidget(complaint: state.complaintList[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: state.complaintList.length,
              ),
            );
          } else if (state is ComplaintError) {
            return Text(state.message);
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
