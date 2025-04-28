import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/presentation/widgets/profile_info_dialog.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppBar({super.key, required this.title});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  void initState() {
    super.initState();
    // Load profile when app bar is initialized
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ProfileInfoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String profileImage = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80';
        
      
        return AppBar(
          toolbarHeight: 100,
          title: Center(
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, size: 30),
                        onPressed: () {
                          // Handle notification button press
                        },
                      ),
                      Positioned(
                        top: 3,
                        right: 3,
                        child: Container(
                          height: 19,
                          width: 19,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC53030),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _showProfileDialog(context),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(profileImage),
                          radius: 24,
                        ),
                        Positioned(
                          bottom: 2,
                          right: 4,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF54D62C),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
