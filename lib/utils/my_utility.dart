// import 'dart:convert';
// import 'dart:io';

// import 'package:beauty_verse/models/upload_model.dart';
// import 'package:beauty_verse/repositories/repository/upload_file_repo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:url_launcher/url_launcher.dart';

// import '../widgets/my_text.dart';
// import 'my_colors.dart';

// showSnackbar({required String msg}) => Get.rawSnackbar(
//       backgroundColor: MyColors.primaryHover,
//       duration: const Duration(milliseconds: 1500),
//       messageText: MyText(color: MyColors.bwWhite, text: msg),
//     );

// showErrSnackbar({required String msg}) => Get.rawSnackbar(
//       backgroundColor: MyColors.red,
//       duration: const Duration(milliseconds: 1500),
//       messageText: MyText(color: MyColors.bwWhite, text: msg.tr),
//     );

// Future changeStatusBool({required RxBool val}) async => val.value = !val.value;

// copy({required String val}) {
//   Clipboard.setData(ClipboardData(text: val));
//   showSnackbar(msg: "Berhasil disalin");
// }

// getTimeRemaining({required DateTime startTime}) {
//   DateTime now = DateTime.now().toLocal();
//   Duration difference = startTime.difference(now);

//   if (difference.isNegative) return "00:00";

//   // int hours = difference.inHours;
//   int minutes = difference.inMinutes.remainder(60);
//   int seconds = (difference.inSeconds % 60);

//   return "${minutes.toString().padLeft(2, '0')}:"
//       "${seconds.toString().padLeft(2, '0')}";
// }

// showMyAdaptiveDialog({
//   required String title,
//   required String cancelText,
//   required String okText,
//   required VoidCallback onCancel,
//   required VoidCallback onOK,
// }) async {
//   final result = await showAdaptiveDialog(
//     context: Get.context!,
//     builder: (context) {
//       if (Platform.isIOS) {
//         return CupertinoAlertDialog(
//           content: Text(title.tr),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               onPressed: onCancel,
//               child: Text(cancelText.tr),
//             ),
//             CupertinoDialogAction(
//               isDestructiveAction: true,
//               onPressed: onOK,
//               child: Text(okText.tr),
//             ),
//           ],
//         );
//       } else {
//         return AlertDialog(
//           backgroundColor: MyColors.bwWhite,
//           content: Text(title.tr),
//           actions: [
//             TextButton(
//               onPressed: onCancel,
//               child: Text(cancelText.tr),
//             ),
//             TextButton(
//               onPressed: onOK,
//               child: Text(okText.tr),
//             ),
//           ],
//         );
//       }
//     },
//   );

//   print("Hasil: $result");
// }

// Future changePict(
//     {required RxString variable, required RxBool isLoading}) async {
//   await showModalBottomSheet(
//     context: Get.context!,
//     useSafeArea: true,
//     builder: (context) => Container(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//       width: Get.size.width,
//       decoration: const BoxDecoration(
//         color: MyColors.black,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () => selectImageFrom(
//                 variable: variable, isLoading: isLoading, gallery: true),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: MyColors.primaryDefault.withValues(alpha: 0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.image_outlined,
//                       color: MyColors.primaryDefault),
//                 ),
//                 const SizedBox(width: 12),
//                 const MyText(
//                   text: "Select from gallery",
//                   color: MyColors.bwWhite,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ],
//             ),
//           ),
//           const Divider(color: MyColors.bwDivider),
//           GestureDetector(
//             onTap: () => selectImageFrom(
//                 variable: variable, isLoading: isLoading, camera: true),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: MyColors.primaryDefault.withValues(alpha: 0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.camera_alt_outlined,
//                     color: MyColors.primaryDefault,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const MyText(
//                   text: "Take from camera",
//                   color: MyColors.bwWhite,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// List<XFile>? fpFile;
// dynamic bytes;
// late String img64;

// set imageFile(XFile? value) {
//   fpFile = value == null ? null : [value];
//   bytes = File(fpFile![0].path).readAsBytesSync();
//   img64 = base64Encode(bytes);
// }

// selectImageFrom({
//   required RxString variable,
//   required RxBool isLoading,
//   bool camera = false,
//   bool gallery = false,
// }) async {
//   isLoading.value = true;

//   ImagePicker picker = ImagePicker();
//   XFile? pickedFile;
//   if (gallery) {
//     pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   } else if (camera) {
//     pickedFile = await picker.pickImage(source: ImageSource.camera);
//   }

//   if (pickedFile != null) {
//     imageFile = pickedFile;

//     var formData = dio.FormData.fromMap({
//       "file": await dio.MultipartFile.fromFile(fpFile![0].path),
//     });

//     var req = await UploadFileRepo().upload(data: formData);
//     await req.responseHandler(
//         res: (res) {
//           var data = <UploadModel>[];
//           data.add(UploadModel.fromJson(res));

//           variable.value = data[0].fullpath;
//         },
//         err: (err) => showErrSnackbar(msg: err));

//     Get.back();
//   }

//   isLoading.value = false;
// }

// execUri({required String uri}) => launchUrl(Uri.parse(uri));
