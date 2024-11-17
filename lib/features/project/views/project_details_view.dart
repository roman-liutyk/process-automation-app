import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/common/utils/enums/user_role_enum.dart';
import 'package:process_automation_app/features/project/providers/project_details_provider.dart';
import 'package:process_automation_app/features/project/views/widgets/add_project_member_dialog.dart';
import 'package:process_automation_app/features/project/views/widgets/project_details_header.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_container.dart';

class ProjectDetailsView extends ConsumerWidget {
  const ProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectDetailsProvider);

    ref.listen<ProjectDetailsState>(
      projectDetailsProvider,
      (previousState, currentState) {
        currentState.whenOrNull(
          loaded: (project, members, errorMessage) {
            if (errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
                  content: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: state.map(
        loaded: (loaded) => ListView(
          children: [
            ProjectDetailsHeader(
              project: loaded.project,
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 24,
              ),
              child: PrimaryContainer(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Team members',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        PrimaryButton(
                          title: 'Add',
                          callback: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const AddProjectMemberDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...List.generate(
                      loaded.members.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                loaded.members[index].imageUrl,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${loaded.members[index].firstName} ${loaded.members[index].lastName}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    loaded.members[index].role.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            loaded.project.id == loaded.members[index].userId ||
                                    loaded.members[index].role ==
                                        UserRoleEnum.owner
                                ? const SizedBox.shrink()
                                : Row(
                                    children: [
                                      const SizedBox(width: 4),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: (loading) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
