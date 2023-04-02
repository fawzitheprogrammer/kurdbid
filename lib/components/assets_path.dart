// OnBoarding Text and image path

// List<String> vectorsPath = [
//   'assets/vectors/onboarding_1.svg',
//   'assets/vectors/onboarding_2.svg',
//   'assets/vectors/onboarding_3.svg'
// ];


// // Key : Value
// Map<String, String> onboardingInfo = {
//   'Welcome':'Thanks for chosing us, You can be \n certain that you chose the best.',
//   'Stop Worrying':'We are here to take care of you and \nyour health and free you from any \nsickness that you might have!',
//   'Just for you':
//       'we made finding doctors who have \nyears of experience easier now, you can \neasily find the doctor that suits your \ncase illness and book an appointment with.'
// };

String getImage({required String folderName,required String fileName}) {
  return 'assets/$folderName/$fileName';
}


/// 