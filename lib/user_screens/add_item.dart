import 'dart:io';

import 'package:intl/intl.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/main.dart';
import 'package:kurdbid/models/item_mode.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/add_item_provider.dart';
import 'package:kurdbid/public_packages.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  File? itemImage;
  final productName = TextEditingController();
  final companyName = TextEditingController();
  final startPrice = TextEditingController();
  final address = TextEditingController();
  Duration duration = const Duration(minutes: 0, seconds: 0);
  final description = TextEditingController();
  String? selectedOption;
  DateTime? dateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    duration;
  }

  @override
  void dispose() {
    super.dispose();
    productName.dispose();
    companyName.dispose();
    startPrice.dispose();
    address.dispose();
    description.dispose();
  }

  // for selecting image
  void selectProfileImage() async {
    itemImage = await pickImage(context);
    setState(() {});
  }

  // void selectIdImage() async {
  //   idImage = await pickImage(context);
  //   setState(() {});
  // }

  final List<String> _options = [
    'Cars',
    'House',
    'Electronics',
    'Furniture',
  ];

  @override
  Widget build(BuildContext context) {
    // final isLoading =
    //     Provider.of<AuthProvider>(context, listen: true).isLoading;

    Future<DateTime> _showDateTimePicker(BuildContext context) async {
      //TimeOfDay initialTime = const TimeOfDay(hour: 9, minute: 0);

      DateTime? selectedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2099, 12, 31),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primaryGreen, // <-- SEE HERE
                onPrimary: backgroundGrey2, // <-- SEE HERE
                onSurface: Colors.blueAccent, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      //dateTime = selectedTime.toString();
      //print(selectedTime);

      return selectedTime!;
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: InkWell(
                      onTap: () => selectProfileImage(),
                      child: itemImage != null
                          ? fields(
                              func: () => selectProfileImage(),
                              file: itemImage,
                            )
                          : fields(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        // name field
                        Row(
                          children: [
                            Flexible(
                              child: textFeld(
                                hintText: "Product name",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: productName,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Flexible(
                              child: textFeld(
                                hintText: "Company name",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: companyName,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: textFeld(
                                hintText: "Start Price",
                                icon: Icons.account_circle,
                                inputType: TextInputType.number,
                                maxLines: 1,
                                controller: startPrice,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                    color: primaryGreen.shade50,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 65.h,
                                width: double.infinity,
                                child: DropdownButton(
                                  hint: textLabel(text: 'Category'),
                                  alignment: Alignment.center,
                                  value: selectedOption,
                                  items: _options.map((options) {
                                    return DropdownMenuItem(
                                      value: options,
                                      child: Text(options),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedOption = value;
                                    setState(() {});
                                  },
                                  underline: Container(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp, color: midGrey1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Flexible(
                            //   child: textFeld(
                            //     hintText: "Address",
                            //     icon: Icons.account_circle,
                            //     inputType: TextInputType.name,
                            //     maxLines: 1,
                            //     controller: address,
                            //   ),
                            // ),

                            Flexible(
                              child: GestureDetector(
                                onTap: () async {
                                  dateTime = await _showDateTimePicker(context);
                                  setState(() {});
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    color: primaryGreen.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 65.h,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: textLabel(
                                        text: dateTime == null
                                            ? 'End Date'
                                            : DateFormat(
                                                    'yyyy-MM-dd EEE, hh:mm a')
                                                .format(dateTime!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 8.w,
                        ),
                        textFeld(
                          hintText: "Description",
                          icon: Icons.account_circle,
                          inputType: TextInputType.name,
                          maxLines: 3,
                          controller: description,
                        ),
                        // // email
                        // textFeld(
                        //   hintText: "abc@example.com",
                        //   icon: Icons.email,
                        //   inputType: TextInputType.emailAddress,
                        //   maxLines: 1,
                        //   controller: emailController,
                        // ),

                        // // bio
                        // textFeld(
                        //   hintText: "Enter your bio here...",
                        //   icon: Icons.edit,
                        //   inputType: TextInputType.name,
                        //   maxLines: 2,
                        //   controller: bioController,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    // height: 50,
                    // width: MediaQuery.of(context).size.width * 0.90,
                    child: primaryButton(
                      label: 'Publish',
                      backgroundColor: primaryGreen,
                      size:
                          Size(MediaQuery.of(context).size.width * 0.90, 70.h),
                      onPressed: () => storeData(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget fields({void Function()? func, File? file}) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: primaryGreen.shade300),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: file == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    getImage(
                      folderName: 'icons',
                      fileName: 'id_add.svg',
                    ),
                    colorFilter: ColorFilter.mode(
                      Colors.blueGrey[(3 + 1) * 100] ?? Colors.blueGrey,
                      BlendMode.srcIn,
                    ),
                    width: 28.w,
                  )

                  // !needLabel ? const Spacer() : Text('')
                ],
              )
            : Image.file(
                file,
                fit: BoxFit.fitHeight,
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    //required TextInputType textInputType,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
        cursorColor: primaryGreen,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          // prefixIcon: Container(
          //   margin: const EdgeInsets.all(8.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     color: Green,
          //   ),
          //   child: Icon(
          //     icon,
          //     size: 20,
          //     color: Colors.white,
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: primaryGreen.shade200, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: primaryGreen, width: 2),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: darkGrey2, width: 2),
          ),
          fillColor: primaryGreen.shade50,
          filled: false,
          hintStyle: GoogleFonts.poppins(fontSize: 14.sp),
        ),
      ),
    );
  }

  //store user data to database
  void storeData() async {
    final ap = Provider.of<ItemAndPostProvider>(context, listen: false);

    final data = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    data.then(
      (value) {
        ap.getToken().then((deviceToken) {
          Item itemModel = Item(
            productName: productName.text,
            companyName: companyName.text,
            imgUrl: '',
            startPrice: startPrice.text,
            category: selectedOption!,
            address: value.get('province') + '-' + value.get('city'),
            duration: dateTime.toString(),
            description: description.text,
            isApproved: false,
            userID: FirebaseAuth.instance.currentUser!.uid,
            userName: value.get('firstName') + ' ' + value.get('lastName'),
            userPhone: value.get('phoneNumber'),
            buyerPrice: startPrice.text,
            buyerName: '',
            buyerId: '',
            buyerPhone: '',
            deviceToken: deviceToken,
          );

          if (itemImage != null) {
            ap.saveItemDataToFirebase(
              context: context,
              item: itemModel,
              img: itemImage!,
              //userID: ItemAndPostProvider.currentUser!.uid,
              onSuccess: () {
                getPageRemoveUntil(context, const AllScreens());
              },
            );
          } else {
            showSnackBar(
              bgColor: Colors.redAccent,
              content: 'Please upload the item photo.',
              context: context,
              textColor: Colors.white,
              // isFalse: true
            );
          }
        });
      },
    );
  }
}
