import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/models.dart';
import '../core/providers/providers.dart';
import '../core/theme/theme.dart';
import '../core/widgets/widgets.dart';

/// Profile Edit Sheet
///
/// Modal bottom sheet for editing user profile information.
class ProfileEditSheet extends ConsumerStatefulWidget {
  final TPSUser user;

  const ProfileEditSheet({super.key, required this.user});

  /// Show the profile edit sheet as a modal bottom sheet.
  static Future<void> show(BuildContext context, TPSUser user) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: TPSColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => ProfileEditSheet(user: user),
    );
  }

  @override
  ConsumerState<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends ConsumerState<ProfileEditSheet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userNameController;
  late TextEditingController _mobileController;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.user.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.user.lastName ?? '',
    );
    _userNameController = TextEditingController(
      text: widget.user.userName ?? '',
    );
    _mobileController = TextEditingController(text: widget.user.mobile ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final updatedUser = TPSUser(
        id: widget.user.id,
        firebaseId: widget.user.firebaseId,
        email: widget.user.email,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        userName: _userNameController.text.trim(),
        mobile: _mobileController.text.trim(),
      );

      final userService = ref.read(userServiceProvider);
      final freshUser = await userService.updateUser(updatedUser);

      ref.read(currentDbUserProvider.notifier).setUser(freshUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: TPSColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to update profile. Please try again.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Edit Profile",
                style: TPSTypography.textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              _buildEditableField(
                "First Name",
                _firstNameController,
                Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                "Last Name",
                _lastNameController,
                Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                "Username",
                _userNameController,
                Icons.alternate_email,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                "Mobile",
                _mobileController,
                Icons.phone_android,
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: TPSColors.error),
                ),
              ],
              const SizedBox(height: 32),
              TPSButton.primary(
                label: "Save Changes",
                isLoading: _isLoading,
                onPressed: _saveProfile,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: TPSColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: TPSColors.textSecondary),
        prefixIcon: Icon(icon, color: TPSColors.cyan),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: TPSColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: TPSColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: TPSColors.cyan),
        ),
        filled: true,
        fillColor: TPSColors.surfaceElevated,
      ),
    );
  }
}
