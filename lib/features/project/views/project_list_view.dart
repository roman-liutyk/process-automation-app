import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/project/providers/project_provider.dart';
import 'package:process_automation_app/features/project/views/widgets/project_item.dart';
import 'package:process_automation_app/features/project/views/widgets/project_list_header.dart';

class ProjectListView extends ConsumerWidget {
  const ProjectListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ProjectListHeader(),
          ),
          state == null
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : state.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'You have no projects',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 24,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.length,
                              itemBuilder: (context, index) {
                                return ProjectItem(
                                    project: state[index],
                                    onTap: () {
                                      context.go('/${state[index].id}/tasks');
                                    });
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
