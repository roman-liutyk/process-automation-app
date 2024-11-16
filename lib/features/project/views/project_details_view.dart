import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/features/project/providers/project_details_provider.dart';
import 'package:process_automation_app/features/project/views/widgets/project_details_header.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_container.dart';

class ProjectDetailsView extends ConsumerWidget {
  const ProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectDetailsProvider);

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
                          callback: () {},
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
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        loading: (loading) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
