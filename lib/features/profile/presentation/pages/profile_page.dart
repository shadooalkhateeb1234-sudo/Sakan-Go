import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../widgets/personal_image_picker.dart';
import '../widgets/profile_text_field.dart';
import '../widgets/id_image_picker.dart';
import '../widgets/wave_header.dart';

class ProfilePage extends StatefulWidget
{
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
{
  final ImagePicker picker = ImagePicker();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDateController = TextEditingController();
  File? personalImage;
  File? idImage;
  bool hasPersonalImage = false;
  bool hasIdImage = false;


  Future<void> pickPersonalImage() async
  {
    showModalBottomSheet
    (
      context: context,
      shape: const RoundedRectangleBorder
      (
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_)
      {
        return SafeArea
        (
          child: Wrap
          (
            children:
            [
              ListTile
              (
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () async
                {
                  Navigator.pop(context);
                  final storageStatus = await Permission.storage.request();
                  if (!storageStatus.isGranted) return;

                  final XFile? image = await picker.pickImage
                  (
                    source: ImageSource.gallery,
                  );

                  if (image != null)
                  {
                    setState
                    (()
                    {
                      personalImage = File(image.path);
                      hasPersonalImage = true;
                    });
                  }
                },
              ),
              ListTile
              (
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () async
                {
                  Navigator.pop(context);

                  final cameraStatus = await Permission.camera.request();
                  if (!cameraStatus.isGranted) return;

                  final XFile? image = await picker.pickImage
                  (
                    source: ImageSource.camera,
                  );

                  if (image != null)
                  {
                    setState
                    (()
                    {
                      personalImage = File(image.path);
                      hasPersonalImage = true;
                    }
                    );
                  }
                }
              )
            ]
          )
        );
      },
    );
  }

  Future<void> pickIdImage() async
  {
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null)
    {
      setState
      (()
      {
        idImage = File(img.path);
        hasIdImage = true;
      });
    }
  }
  bool get valid => firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && birthDateController.text.isNotEmpty && hasPersonalImage && hasIdImage;

  Future<void> pickDate() async
  {
    final d = await showDatePicker
    (
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime(2008),
    );
    if (d != null)
    {
      birthDateController.text = "${d.year}-${d.month}-${d.day}";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.secondaryContainer,
      body: SingleChildScrollView
      (
        child: Stack
        (
          children:
          [
            const WaveHeader(),

            PersonalImagePicker
            (
              personalImage: personalImage,
              onTap: () => pickPersonalImage(),
            ),

            Padding
            (
              padding: const EdgeInsets.fromLTRB(16, 260, 16, 16),
              child: Column
              (
                children:
                [
                  const SizedBox(height: 50),

                  const Text("Profile", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 24),

                  Row
                  (
                    children:
                    [
                      Expanded
                      (
                        child: ProfileTextField
                        (
                          controller: firstNameController,
                          label: "First Name",
                          icon: Icons.person_outlined,
                          topLeftRadius: 50,
                          topRightRadius: 0,
                          bottomLeftRadius: 50,
                          bottomRightRadius: 0,
                        )
                      ),
                      const SizedBox(width: 12),
                      Expanded
                      (
                        child: ProfileTextField
                        (
                          controller: lastNameController,
                          label: "Last Name",
                          icon: Icons.person_outline,
                          topLeftRadius: 0,
                          topRightRadius: 50,
                          bottomLeftRadius: 0,
                          bottomRightRadius: 50,
                        )
                      )
                    ]
                  ),

                  const SizedBox(height: 16),

                  ProfileTextField
                  (
                    controller: birthDateController,
                    label: "Birth Date",
                    icon: Icons.calendar_month,
                    readOnly: true,
                    onTap: pickDate, topLeftRadius: 50, topRightRadius: 50, bottomLeftRadius: 50, bottomRightRadius: 50,
                  ),

                  const SizedBox(height: 16),

                  IdImagePicker(
                    selected: hasIdImage,
                    onTap: pickIdImage,
                    borderWidth: 2.5,
                    enabledBorderColor: Colors.grey,
                    selectedBorderColor: Colors.blue,
                  ),


                  const SizedBox(height: 24),

                  SizedBox
                  (
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton
                    (
                      onPressed: valid ? () {} : null,
                      style: ElevatedButton.styleFrom
                      (
                        shape: RoundedRectangleBorder
                        (
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      child: const Text("Submit"),
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}