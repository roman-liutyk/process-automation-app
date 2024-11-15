import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/home/widgets/home_header.dart';
import 'package:process_automation_app/features/home/widgets/project_card.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        name: 'Project Alpha',
        description: 'Mobile app development',
        tasks: 24,
        members: 12,
      ),
      Project(
        name: 'Project Beta',
        description: 'Website redesign',
        tasks: 18,
        members: 8,
      ),
      Project(
        name: 'Project Alpha',
        description: 'Mobile app development',
        tasks: 24,
        members: 12,
      ),
      Project(
        name: 'Project Beta',
        description: 'Website redesign',
        tasks: 18,
        members: 8,
      ),
      Project(
        name: 'Project Alpha',
        description: 'Mobile app development',
        tasks: 24,
        members: 12,
      ),
      Project(
        name: 'Project Beta',
        description: 'Website redesign',
        tasks: 18,
        members: 8,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const HomeHeader(),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ProjectCard(
                        project: projects[index],
                        onTap: () => context.push('/project/index'),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
