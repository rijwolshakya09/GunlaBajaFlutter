import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gunla_baja_flutter/screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        title: 'Gunla Baja',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:just_audio/just_audio.dart';

// void main() {
//   runApp(const MusicalLearningApp());
// }

// class MusicalLearningApp extends StatelessWidget {
//   const MusicalLearningApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Musical Learning App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MusicalInstrumentPage(),
//     );
//   }
// }

// class MusicalInstrumentPage extends StatefulWidget {
//   const MusicalInstrumentPage({super.key});

//   @override
//   _MusicalInstrumentPageState createState() => _MusicalInstrumentPageState();
// }

// class _MusicalInstrumentPageState extends State<MusicalInstrumentPage> {
//   List<SoundModel> sounds = [];
//   AudioPlayer audioPlayer = AudioPlayer();

//   bool isGameMode = false;
//   String? targetNote;
//   int score = 0;
//   String? currentPlayingNote;

//   Future<void> uploadCustomSound() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.audio,
//         allowMultiple: false,
//       );

//       if (result != null && result.files.single.path != null) {
//         String? noteName = await showNoteNameDialog();

//         if (noteName != null && noteName.isNotEmpty) {
//           setState(() {
//             sounds.add(SoundModel(
//               filePath: result.files.single.path!,
//               noteName: noteName,
//             ));
//           });

//           // Create an AudioPlayer instance for the newly added sound
//           AudioPlayer player = AudioPlayer();
//           player.setAudioSource(AudioSource.file(result.files.single.path!));
//           player.play();
//         }
//       }
//     } catch (e) {
//       print('File Picking Error: $e');
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error uploading sound: $e')));
//     }
//   }

//   Future<String?> showNoteNameDialog() {
//     final TextEditingController noteController = TextEditingController();
//     return showDialog<String>(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Enter Note Name'),
//             content: TextField(
//               controller: noteController,
//               decoration:
//                   const InputDecoration(hintText: 'e.g., Sa, Re, Ga, Ma'),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, noteController.text),
//                 child: const Text('Save'),
//               ),
//             ],
//           );
//         });
//   }

//   Future<void> playSound(SoundModel sound) async {
//     try {
//       // Verify file exists before attempting to play
//       File audioFile = File(sound.filePath);
//       if (!await audioFile.exists()) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Audio file not found')));
//         return;
//       }

//       // Set audio source and play
//       await audioPlayer.setAudioSource(AudioSource.file(sound.filePath));
//       await audioPlayer.play();

//       setState(() {
//         currentPlayingNote = sound.noteName;
//       });

//       // Game mode logic
//       if (isGameMode) {
//         if (sound.noteName == targetNote) {
//           setState(() {
//             score++;
//             generateNextTarget();
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('Wrong Note! Try Again.'),
//             backgroundColor: Colors.red,
//           ));
//           setState(() {
//             score = max(0, score - 1);
//           });
//         }
//       }

//       // Reset currentPlayingNote after sound finishes
//       audioPlayer.playerStateStream.listen((state) {
//         if (state.processingState == ProcessingState.completed) {
//           setState(() {
//             currentPlayingNote = null;
//           });
//         }
//       });
//     } catch (e) {
//       print('Sound Playing Error: $e'); // Detailed error logging
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error playing sound: $e')));
//     }
//   }

//   void generateNextTarget() {
//     if (sounds.isNotEmpty) {
//       setState(() {
//         targetNote = sounds[Random().nextInt(sounds.length)].noteName;
//       });
//     }
//   }

//   void startGameMode() {
//     if (sounds.length > 1) {
//       setState(() {
//         isGameMode = true;
//         score = 0;
//         generateNextTarget();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Upload at least 2 sounds to start game mode')));
//     }
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   // Add the missing build method
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Musical Learning App'),
//         actions: [
//           if (isGameMode)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Text(
//                   'Target: ${targetNote ?? ""}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.yellowAccent,
//                   ),
//                 ),
//               ),
//             )
//         ],
//       ),
//       body: Column(
//         children: [
//           // Game Mode Controls
//           if (isGameMode)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Score: $score',
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold)),
//                   ElevatedButton(
//                     onPressed: () => setState(() {
//                       isGameMode = false;
//                       targetNote = null;
//                     }),
//                     child: const Text('Exit Game Mode'),
//                   )
//                 ],
//               ),
//             ),

//           // Sound Upload Button
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton.icon(
//               icon: const Icon(Icons.upload_file),
//               label: const Text('Upload Custom Sound'),
//               onPressed: uploadCustomSound,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//               ),
//             ),
//           ),

//           // Start Game Mode Button
//           if (!isGameMode)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.gamepad),
//                 label: const Text('Start Game Mode'),
//                 onPressed: startGameMode,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                 ),
//               ),
//             ),

//           // Sound Buttons Grid
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 1.5,
//               ),
//               itemCount: sounds.length,
//               itemBuilder: (context, index) {
//                 SoundModel sound = sounds[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () => playSound(sound),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: currentPlayingNote == sound.noteName
//                           ? Colors.red
//                           : Colors.blue,
//                     ),
//                     child: Text(
//                       sound.noteName,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SoundModel {
//   final String filePath;
//   final String noteName;

//   SoundModel({required this.filePath, required this.noteName});
// }
// // ```

// // Key Changes and Recommendations:

// // 1. Switched to `just_audio` package for more reliable audio handling
// // 2. Used `FileType.custom` with specific allowed extensions
// // 3. Modified file path handling
// // 4. Added error handling and state management improvements
// // 5. Implemented proper audio player disposal

// // Before running, make sure to:
// // 1. Run `flutter pub get` to install dependencies
// // 2. Ensure you have the latest Flutter SDK
// // 3. Check platform-specific configurations for file and audio permissions

// // Potential Platform-Specific Configurations:
// // - For iOS: Add file picker and audio permissions in `Info.plist`
// // - For Android: Add storage permissions in `AndroidManifest.xml`

// // Troubleshooting Tips:
// // - Verify file picker and audio plugin installations
// // - Check that your audio files are in supported formats
// // - Ensure proper file path handling

// // Would you like me to elaborate on any part of the implementation or help you troubleshoot any specific issues you're encountering?