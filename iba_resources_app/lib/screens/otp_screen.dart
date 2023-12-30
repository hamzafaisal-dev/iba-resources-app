// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// final ButtonStyle customButtonStyle = ButtonStyle(
//   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//     RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(6.0),
//     ),
//   ),
//   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//     const EdgeInsets.symmetric(vertical: 18.0),
//   ),
// );

// final _firebase = FirebaseAuth.instance;

// class OTPScreen extends StatefulWidget {
//   const OTPScreen({super.key});

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   late String email;

//   void verifyOtp() async {
//     debugPrint('Called');

//     await _firebase.sendSignInLinkToEmail(
//       email: email,
//       actionCodeSettings: ActionCodeSettings(
//         url: "https://mail.google.com/",
//         handleCodeInApp: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //get arguments from route
//     final routeArguments =
//         ModalRoute.of(context)?.settings.arguments as Map<String, String>;

//     email = routeArguments['email'].toString();

//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(24),
//           children: [
//             //
//             const SizedBox(height: 190),

//             const Text(
//               'CO\nDE',
//               style: TextStyle(
//                 fontSize: 80,
//                 fontWeight: FontWeight.bold,
//                 height: 1,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const Text(
//               'VERIFICATION',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 20),

//             Text(
//               'Enter the verification code sent at $email',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 20),

//             OtpTextField(
//               numberOfFields: 6,
//               keyboardType: TextInputType.number,
//             ),

//             const SizedBox(height: 20),

//             //next button
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 38),
//               width: MediaQuery.of(context).size.width,
//               child: FilledButton(
//                 onPressed: verifyOtp,
//                 style: customButtonStyle,
//                 child: const Text(
//                   'NEXT',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
