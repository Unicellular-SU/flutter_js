// ignore_for_file: unused_import

// import 'dart:developer';
import 'dart:ffi' show DynamicLibrary;
import 'dart:io';

import 'package:flutter/services.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// class MyDynamicLib {
//   static DynamicLibrary? qjsLib;
//   static final methodChannel = const MethodChannel('io.abner.flutter_js');

//   static Future<String?> _getNativeLibraryDirectory() =>
//       methodChannel.invokeMethod<String?>("getNativeLibraryDirectory");

//   static Future<DynamicLibrary> getAndroidDynamicLibrary(
//       String libraryName) async {
//     try {
//       return DynamicLibrary.open(libraryName);
//     } catch (_) {
//       try {
//         final String? nativeLibraryDirectory =
//             await _getNativeLibraryDirectory();

//         return DynamicLibrary.open('$nativeLibraryDirectory/$libraryName');
//       } catch (_) {
//         try {
//           final PackageInfo packageInfo = await PackageInfo.fromPlatform();
//           final String packageName = packageInfo.packageName;

//           return DynamicLibrary.open(
//               '/data/data/$packageName/lib/$libraryName');
//         } catch (_) {
//           rethrow;
//         }
//       }
//     }
//   }

//   static Future<void> initDynamicLibrary() async {
//     qjsLib = Platform.environment['FLUTTER_TEST'] == 'true'
//         ? (Platform.isWindows
//             ? DynamicLibrary.open('quickjs_c_bridge.dll')
//             : Platform.isMacOS
//                 ? DynamicLibrary.process()
//                 : DynamicLibrary.open(
//                     Platform.environment['LIBQUICKJSC_TEST_PATH'] ??
//                         'libquickjs_c_bridge_plugin.so'))
//         : (Platform.isWindows
//             ? DynamicLibrary.open('quickjs_c_bridge.dll')
//             : (Platform.isLinux
//                 ? DynamicLibrary.open(
//                     Platform.environment['LIBQUICKJSC_PATH'] ??
//                         'libquickjs_c_bridge_plugin.so')
//                 : (Platform.isAndroid
//                     ? await getAndroidDynamicLibrary(
//                         'libfastdev_quickjs_runtime.so')
//                     : DynamicLibrary.process())));
//   }
// }

class MyDLikLib {
  static final MyDLikLib _myDLikLib = MyDLikLib._internal();

  // DynamicLibrary? qjsLib;
  String? _pathNativeDirectory;
  String? _packageName;

  final methodChannel = const MethodChannel('io.abner.flutter_js');
  // Future<String?> _getNativeLibraryDirectory() =>
  //     methodChannel.invokeMethod<String?>("getNativeLibraryDirectory");

  DynamicLibrary getAndroidDynamicLibrary(String libraryName) {
    try {
      return DynamicLibrary.open(libraryName);
    } catch (_) {
      try {
        // final String? nativeLibraryDirectory =
        //     await _getNativeLibraryDirectory();

        // log('_path--->$_pathNativeDirectory/$libraryName');
        // return DynamicLibrary.open('$_pathNativeDirectory/$libraryName');
        return DynamicLibrary.open(libraryName);
      } catch (_) {
        try {
          // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
          // final String packageName = packageInfo.packageName;

          // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
          // final String _packageName = packageInfo.packageName;
          // log('path--->/data/data/$_packageName/lib/$libraryName');

          return DynamicLibrary.open(
              '/data/data/$_packageName/lib/$libraryName');
        } catch (_) {
          try {
            // log('_path--->$_pathNativeDirectory/$libraryName');
            return DynamicLibrary.open('$_pathNativeDirectory/$libraryName');
          } catch (e) {
            // log('path--->$e');
            rethrow;
          }
        }
      }
    }
  }

  void setNativeDir({required String nativeDir}) {
    _pathNativeDirectory = nativeDir;
  }

  void setPackageName({required String packageName}) {
    _packageName = packageName;
    // _pathNativeDirectory = await _getNativeLibraryDirectory();
    // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // _packageName = packageInfo.packageName;
    // print('_pathNativeDirectory--->$_pathNativeDirectory');
    // print('_packageName--->io.abner.flutter_js_example');
  }

  DynamicLibrary getDynamicLibrary() {
    return Platform.environment['FLUTTER_TEST'] == 'true'
        ? (Platform.isWindows
            ? DynamicLibrary.open('quickjs_c_bridge.dll')
            : Platform.isMacOS
                ? DynamicLibrary.process()
                : DynamicLibrary.open(
                    Platform.environment['LIBQUICKJSC_TEST_PATH'] ??
                        'libquickjs_c_bridge_plugin.so'))
        : (Platform.isWindows
            ? DynamicLibrary.open('quickjs_c_bridge.dll')
            : (Platform.isLinux
                ? DynamicLibrary.open('libquickjs_c_bridge_plugin.so')
                : (Platform.isAndroid
                    ? getAndroidDynamicLibrary('libfastdev_quickjs_runtime.so')
                    : DynamicLibrary.process())));
  }

  factory MyDLikLib() {
    return _myDLikLib;
  }

  MyDLikLib._internal();
}
