import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';
import 'package:process_automation_app/features/project/views/widgets/project_item.dart';
import 'package:process_automation_app/features/project/views/widgets/project_list_header.dart';
import 'package:process_automation_app/features/task/providers/task_provider.dart';

final List<ProjectModel> sampleProjects = [
  const ProjectModel(
    uuid: '8f7e6d5c-4b3a-2m1n-9o8p-7q6r5s4t3u2v',
    name: 'Mobile App Redesign',
    description:
        'Complete overhaul of the mobile application UI/UX with focus on improved user experience and modern design principles',
    status: ProjectStatusEnum.active,
  ),
  const ProjectModel(
    uuid: '1a2b3c4d-5e6f-7g8h-9i0j-1k2l3m4n5o6p',
    name: 'Backend Migration',
    description:
        'Migration of legacy backend systems to microservices architecture using modern cloud technologies',
    status: ProjectStatusEnum.onHold,
  ),
  const ProjectModel(
    uuid: '9p8o7n6m-5l4k-3j2i-1h0g-9f8e7d6c5b4a',
    name: 'Data Analytics Platform',
    description:
        'Development of comprehensive data analytics platform for business intelligence and reporting',
    status: ProjectStatusEnum.completed,
  ),
  const ProjectModel(
    uuid: '2q3r4s5t-6u7v-8w9x-0y1z-2a3b4c5d6e7f',
    name: 'Security Audit Implementation',
    description:
        'Implementation of security measures and protocols based on recent audit findings',
    status: ProjectStatusEnum.active,
  ),
  const ProjectModel(
    uuid: '7g8h9i0j-1k2l-3m4n-5o6p-7q8r9s0t1u2v',
    name: 'E-commerce Integration',
    description:
        'Integration of new payment gateways and shipping providers into existing e-commerce platform',
    status: ProjectStatusEnum.cancelled,
  ),
  const ProjectModel(
    uuid: '3w4x5y6z-7a8b-9c0d-1e2f-3g4h5i6j7k8l',
    name: 'Cloud Migration',
    description:
        'Migration of on-premise infrastructure to cloud-based solutions for improved scalability',
    status: ProjectStatusEnum.onHold,
  ),
  const ProjectModel(
    uuid: '9m0n1o2p-3q4r-5s6t-7u8v-9w0x1y2z3a4b',
    name: 'Customer Portal Enhancement',
    description:
        'Enhancement of customer self-service portal with new features and improved performance',
    status: ProjectStatusEnum.active,
  ),
  const ProjectModel(
    uuid: '5c6d7e8f-9g0h-1i2j-3k4l-5m6n7o8p9q0r',
    name: 'API Modernization',
    description:
        'Modernization of legacy APIs to RESTful architecture with improved documentation',
    status: ProjectStatusEnum.completed,
  ),
  const ProjectModel(
    uuid: '1s2t3u4v-5w6x-7y8z-9a0b-1c2d3e4f5g6h',
    name: 'DevOps Pipeline Setup',
    description:
        'Implementation of automated CI/CD pipeline for streamlined deployment process',
    status: ProjectStatusEnum.active,
  ),
  const ProjectModel(
    uuid: '7i8j9k0l-1m2n-3o4p-5q6r-7s8t9u0v1w2x',
    name: 'Mobile App Testing Framework',
    description:
        'Development of automated testing framework for mobile applications',
    status: ProjectStatusEnum.onHold,
  ),
];

class ProjectListView extends ConsumerWidget {
  const ProjectListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ProjectListHeader(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sampleProjects.length,
                  itemBuilder: (context, index) {
                    return ProjectItem(
                        project: sampleProjects[index],
                        onTap: () {
                          ref.read(taskProvider.notifier).fetchTasks(
                                projectId: sampleProjects[index].uuid,
                              );
                          context.go('/${sampleProjects[index].uuid}/tasks');
                        });
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
