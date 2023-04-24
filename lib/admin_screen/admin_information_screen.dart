import 'dart:io';

import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/main.dart';
import 'package:kurdbid/models/admin_model.dart';
import 'package:kurdbid/providers/providers_barrel.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/user_screens/login_screen.dart';

class AdminInformationScreen extends StatefulWidget {
  const AdminInformationScreen({super.key});

  @override
  State<AdminInformationScreen> createState() => _AdminInformationScreenState();
}

class _AdminInformationScreenState extends State<AdminInformationScreen> {
  File? profileImage;
  //File? idImage;
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  // final bioController = TextEditingController();
  // String? selectedOption;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
    //bioController.dispose();
  }

  // for selecting image
  void selectProfileImage() async {
    profileImage = await pickImage(context);
    setState(() {});
  }

  // void selectIdImage() async {
  //   idImage = await pickImage(context);
  //   setState(() {});
  // }

  // final List<String> _options = [
  //   'Male',
  //   'Female',
  // ];

  @override
  Widget build(BuildContext context) {
    // final isLoading =
    //     Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: !true
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryGreen,
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 5.0),
                  child: Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => selectProfileImage(),
                          child: profileImage == null
                              ? CircleAvatar(
                                  backgroundColor: primaryGreen,
                                  radius: 50,
                                  child: const Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(profileImage!),
                                  radius: 50,
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // name field
                              Row(
                                children: [
                                  Flexible(
                                    child: textFeld(
                                      hintText: "First name",
                                      icon: Icons.account_circle,
                                      inputType: TextInputType.name,
                                      maxLines: 1,
                                      controller: nameController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Flexible(
                                    child: textFeld(
                                      hintText: "Last name",
                                      icon: Icons.account_circle,
                                      inputType: TextInputType.name,
                                      maxLines: 1,
                                      controller: lastNameController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8.w,
                              ),

                              // Row(
                              //   children: [
                              //     Flexible(
                              //       child: textFeld(
                              //         hintText: "Province",
                              //         icon: Icons.account_circle,
                              //         inputType: TextInputType.name,
                              //         maxLines: 1,
                              //         controller: nameController,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 8.w,
                              //     ),
                              //     Flexible(
                              //       child: textFeld(
                              //         hintText: "City",
                              //         icon: Icons.account_circle,
                              //         inputType: TextInputType.name,
                              //         maxLines: 1,
                              //         controller: nameController,
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // GestureDetector(
                              //   onTap: () => selectIdImage(),
                              //   child: Container(
                              //     padding:
                              //         EdgeInsets.symmetric(horizontal: 14.w),
                              //     height: 70.h,
                              //     decoration: BoxDecoration(
                              //       border: Border.all(
                              //           width: 1.5,
                              //           color: primaryGreen.shade300),
                              //       borderRadius: BorderRadius.circular(10.r),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Flexible(
                              //           child: textLabel(
                              //             text: idImage == null
                              //                 ? 'ID Card'
                              //                 : idImage!.path
                              //                     .split('/')
                              //                     .last
                              //                     .toString(),
                              //             color: midGrey1,
                              //             fontWeight: FontWeight.w400,
                              //           ),
                              //         ),
                              //         //const Spacer(),
                              //         SvgPicture.asset(
                              //           getImage(
                              //             folderName: 'icons',
                              //             fileName: 'id_add.svg',
                              //           ),
                              //           colorFilter: ColorFilter.mode(
                              //             Colors.blueGrey[(2 + 1) * 100] ??
                              //                 Colors.blueGrey,
                              //             BlendMode.srcIn,
                              //           ),
                              //           width: 28.w,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              // SizedBox(
                              //   height: 8.w,
                              // ),
                              // textFeld(
                              //   hintText: "ID Card  Number",
                              //   icon: Icons.account_circle,
                              //   inputType: TextInputType.name,
                              //   maxLines: 1,
                              //   controller: nameController,
                              // ),
                              // // // email
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
                        //const SizedBox(height: 20),
                        SizedBox(
                          // height: 50,
                          // width: MediaQuery.of(context).size.width * 0.90,
                          child: primaryButton(
                            label: 'Register',
                            backgroundColor: primaryGreen,
                            size: Size(
                                MediaQuery.of(context).size.width * 0.90, 70.h),
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

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
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
    final ap = Provider.of<AuthProvider>(context, listen: false);

    AdminModel adminModel = AdminModel(
      uid: "",
      firstName: nameController.text,
      phoneNumber: phoneNumberOnBoarding!,
      lastName: lastNameController.text,
      profileImgUrl: '',
    );

    if (profileImage != null && nameController.text.isNotEmpty) {
      ap.saveAdminDataToFirebase(
        context: context,
        adminModel: adminModel,
        profilePic: profileImage!,
        onSuccess: () {
          ap.saveAdminDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllScreens(),
                        ),
                        (route) => false,
                      ),
                    ),
              );
        },
      );
    } else {
      showSnackBar(
        bgColor: Colors.redAccent,
        content: 'Please upload your profile photo.',
        context: context,
        textColor: Colors.white,
        // isFalse: true
      );
    }
  }
}
