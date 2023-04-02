import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/components/image_card.dart';
import 'package:kurdbid/public_packages.dart';

class PendingItemScreen extends StatelessWidget {
  const PendingItemScreen({super.key});

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
                    LimitedBox(
                      maxHeight: 100.h,
                      maxWidth: 100.w,
                      child: fields(
                        'watch.jpg',
                        Size(
                          100.w,
                          100.h,
                        ),
                        BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textLabel(text: 'Watch', fontSize: 20.sp),
                          textLabel(
                              text: 'Start Price : \$220', fontSize: 14.sp),
                          textLabel(text: 'Brand : Lifewear', fontSize: 14.sp),
                        ],
                      ),
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
