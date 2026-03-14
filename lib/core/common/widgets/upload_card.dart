import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/common/widgets/bottom_sheet_option_tile.dart';
import 'package:rafeeq_app/core/common/widgets/custom_bottom_sheet.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';

class UploadCard extends StatefulWidget {
  const UploadCard({super.key, required this.onImageSelected});
  final Function(String?) onImageSelected;
  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  File? selectedImage;
  bool _isPickingImage = false;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    if (_isPickingImage) return;

    _isPickingImage = true;

    try {
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image != null) {
        final file = File(image.path);

        if (!mounted) return;

        setState(() {
          selectedImage = file;
        });

        widget.onImageSelected(image.path);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isPickingImage = false;

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _showImagePickerSheet() {
    final options = [
      BottomSheetOptionTile(
        icon: AppIcons.cameraIcon,
        title: 'التقاط الصورة',
        onTap: () => _pickImage(ImageSource.camera),
      ),
      BottomSheetOptionTile(
        icon: AppIcons.galleryAddIcon,
        title: 'اختر صورة موجودة',
        onTap: () => _pickImage(ImageSource.gallery),
      ),
      if (selectedImage != null)
        BottomSheetOptionTile(
          icon: AppIcons.trashIcon,
          title: 'حذف الصورة',
          isDestructive: true,
          onTap: () {
            setState(() => selectedImage = null);
            widget.onImageSelected(null);
            Navigator.pop(context);
          },
        ),
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomBottomSheet(
          title: 'الصورة الشخصية',
          children: [
            for (int i = 0; i < options.length; i++)
              FadeInUp(
                duration: Duration(milliseconds: 400 + i * 150),
                child: options[i],
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          InkWell(
            onTap: _showImagePickerSheet,
            child: CircleAvatar(
              radius: 55.r,
              backgroundColor: context.customAppColors.grey200,
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : null,
              child: selectedImage == null
                  ? Icon(
                      Icons.person,
                      size: 50.sp,
                      color: context.customAppColors.grey600,
                    )
                  : null,
            ),
          ),
          GestureDetector(
            onTap: _showImagePickerSheet,
            child: Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(
                color: context.customAppColors.primary800,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.edit, size: 18.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
