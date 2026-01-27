import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tps_core/core/models/models.dart';
import 'package:tps_core/core/providers/providers.dart';
import 'package:tps_core/core/theme/theme.dart';
import 'package:tps_core/core/widgets/widgets.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userNameController;
  late TextEditingController _mobileController;

  bool _isLoading = false;
  String? _errorMessage;
  TPSUser? _initialUser;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _userNameController = TextEditingController();
    _mobileController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _populateControllers(TPSUser user) {
    if (_initialUser == user) return; // No change

    _initialUser = user;
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _userNameController.text = user.userName ?? '';
    _mobileController.text = user.mobile ?? '';
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (_initialUser == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final updatedUser = TPSUser(
        id: _initialUser!.id,
        firebaseId: _initialUser!.firebaseId,
        email: _initialUser!.email, // Email is read-only
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        userName: _userNameController.text.trim(),
        mobile: _mobileController.text.trim(),
      );

      final userService = ref.read(userServiceProvider);
      final freshUser = await userService.updateUser(updatedUser);

      // Directly update the provider to avoid refetch
      ref.read(currentDbUserProvider.notifier).setUser(freshUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: TPSColors.success,
          ),
        );
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
    final userAsync = ref.watch(currentDbUserProvider);

    return Scaffold(
      backgroundColor: TPSColors.charcoal,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: TPSColors.charcoal,
        elevation: 0,
        centerTitle: true,
      ),
      body: userAsync.when(
        data: (user) {
          print("User: ${user?.toJson()}");
          if (user == null) {
            return const Center(child: Text("User not found."));
          }
          return _buildContent(user);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(TPSUser user) {
    return SingleChildScrollView(
      padding: TPSSpacing.pagePadding,
      child: Column(
        children: [
          Center(child: _buildHeader(user)),
          const SizedBox(height: 48),

          // Options List
          Container(
            decoration: BoxDecoration(
              color: TPSColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: TPSColors.glassBorder.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                _buildOptionTile(
                  label: "Edit Profile",
                  icon: Icons.edit_outlined,
                  onTap: () => _showEditSheet(user),
                  showDivider: false,
                ),
                // Future options can go here
              ],
            ),
          ),

          const SizedBox(height: 48),

          TPSButton.ghost(
            label: "Sign Out",
            icon: Icons.logout,
            onPressed: () async {
              final authService = ref.read(authServiceProvider);
              await authService.signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(TPSUser user) {
    final hasPhoto = user.photoUrl != null && user.photoUrl!.isNotEmpty;

    // Initials Logic
    String initials = "";
    if (!hasPhoto) {
      final first = (user.firstName ?? "").trim();
      final last = (user.lastName ?? "").trim();
      if (first.isNotEmpty) initials += first[0].toUpperCase();
      if (last.isNotEmpty) initials += last[0].toUpperCase();
      if (initials.isEmpty) initials = "?";
    }

    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: TPSColors.cyan.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: TPSColors.cyan.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: TPSColors.surfaceElevated,
            backgroundImage: hasPhoto ? NetworkImage(user.photoUrl!) : null,
            child: !hasPhoto
                ? Text(
                    initials,
                    style: TPSTypography.textTheme.displayMedium?.copyWith(
                      color: TPSColors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "${user.firstName ?? ''} ${user.lastName ?? ''}".trim(),
          style: TPSTypography.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (user.userName != null) ...[
          const SizedBox(height: 4),
          Text(
            "@${user.userName}",
            style: TPSTypography.textTheme.bodyMedium?.copyWith(
              color: TPSColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOptionTile({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: TPSColors.cyan.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: TPSColors.cyan, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TPSTypography.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: TPSColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditSheet(TPSUser user) {
    _populateControllers(user);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: TPSColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
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
                Consumer(
                  // Use Consumer to access state if needed or pass setState down
                  builder: (context, ref, _) {
                    return TPSButton.primary(
                      label: "Save Changes",
                      isLoading: _isLoading,
                      onPressed: () async {
                        await _saveProfile();
                        if (mounted && _errorMessage == null) {
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
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
