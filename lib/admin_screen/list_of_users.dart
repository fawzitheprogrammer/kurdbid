import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/public_packages.dart';

class ListOfUsers extends StatelessWidget {
  const ListOfUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              height: 150.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(24.0.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryGreen,
                      radius: 35.r,
                      child: Icon(
                        Icons.person,
                        size: 30.r,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textLabel(text: 'Muhamad Kamal', fontSize: 20.sp),
                        textLabel(text: 'Erbil, Soran', fontSize: 14.sp),
                        textLabel(text: '3423423423', fontSize: 14.sp),
                      ],
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customButton(() {}, Icons.check, Colors.green),
                          SizedBox(
                            width: 6.w,
                          ),
                          customButton(() {}, Icons.close, Colors.red),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
