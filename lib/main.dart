import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardApp());
}

// ================================================================
// APP
// ================================================================

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.indigo,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ================================================================
// COLORS
// ================================================================

class AppColors {
  static const Color navy = Color(0xFF111827);
  static const Color navyLight = Color(0xFF1F2937);

  static const Color indigo = Color(0xFF6366F1);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color green = Color(0xFF22C55E);
  static const Color orange = Color(0xFFF97316);
  static const Color pink = Color(0xFFEC4899);
  static const Color red = Color(0xFFEF4444);
  static const Color yellow = Color(0xFFF59E0B);

  static const Color background = Color(0xFFF5F7FA);
  static const Color white = Colors.white;

  static const Color text = Color(0xFF172033);
  static const Color muted = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
}

// ================================================================
// DATA MODELS
// ================================================================

class StatData {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const StatData(
    this.title,
    this.value,
    this.change,
    this.icon,
    this.color,
  );
}

class ProjectData {
  final String title;
  final String team;
  final double progress;
  final IconData icon;
  final Color color;

  const ProjectData(
    this.title,
    this.team,
    this.progress,
    this.icon,
    this.color,
  );
}

class ActivityData {
  final String title;
  final String time;
  final IconData icon;
  final Color color;

  const ActivityData(
    this.title,
    this.time,
    this.icon,
    this.color,
  );
}

// ================================================================
// DASHBOARD SCREEN
// ================================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const stats = [
    StatData(
      'Total Revenue',
      '\$24.5K',
      '+12.4%',
      Icons.account_balance_wallet_outlined,
      AppColors.indigo,
    ),
    StatData(
      'Total Orders',
      '1,204',
      '+8.2%',
      Icons.shopping_cart_outlined,
      AppColors.cyan,
    ),
    StatData(
      'Customers',
      '3,842',
      '+5.7%',
      Icons.people_alt_outlined,
      AppColors.green,
    ),
    StatData(
      'Pending',
      '18',
      '-2.1%',
      Icons.access_time_rounded,
      AppColors.orange,
    ),
  ];

  static const projects = [
    ProjectData(
      'Website Revamp',
      'Design Team',
      0.75,
      Icons.web_outlined,
      AppColors.indigo,
    ),
    ProjectData(
      'Mobile App V2',
      'Development',
      0.45,
      Icons.smartphone_outlined,
      AppColors.cyan,
    ),
    ProjectData(
      'Marketing Q3',
      'Growth Team',
      0.90,
      Icons.campaign_outlined,
      AppColors.orange,
    ),
    ProjectData(
      'API Migration',
      'Backend Team',
      0.30,
      Icons.dns_outlined,
      AppColors.green,
    ),
    ProjectData(
      'User Research',
      'UX Team',
      0.60,
      Icons.groups_outlined,
      AppColors.pink,
    ),
    ProjectData(
      'Support Portal',
      'Support Team',
      0.20,
      Icons.support_agent_outlined,
      AppColors.yellow,
    ),
  ];

  static const activities = [
    ActivityData(
      'Order #2481 placed',
      '2 minutes ago',
      Icons.shopping_bag_outlined,
      AppColors.indigo,
    ),
    ActivityData(
      'New user registered',
      '10 minutes ago',
      Icons.person_add_alt_outlined,
      AppColors.green,
    ),
    ActivityData(
      'Server backup completed',
      '1 hour ago',
      Icons.cloud_done_outlined,
      AppColors.cyan,
    ),
    ActivityData(
      'Payment failed for #2477',
      '2 hours ago',
      Icons.warning_amber_rounded,
      AppColors.red,
    ),
    ActivityData(
      'New comment on report',
      '3 hours ago',
      Icons.chat_bubble_outline,
      AppColors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool mobile = width < 700;
    final bool tablet = width >= 700 && width < 1100;

    return Scaffold(
      body: Row(
        children: [
          // ========================================================
          // DESKTOP SIDEBAR
          // ========================================================

          if (!mobile) const _Sidebar(),

          // ========================================================
          // MAIN AREA
          // ========================================================

          Expanded(
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _TopBar(mobile: mobile),
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mobile
                          ? 16
                          : tablet
                              ? 24
                              : 38,
                      vertical: 24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          // ==================================================
                          // WELCOME SECTION
                          // ==================================================

                          const Text(
                            'Good evening, Payal👋',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            'Here is your business overview for today.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.muted,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // ==================================================
                          // STATS
                          // ==================================================

                          _SectionHeading(
                            title: 'Performance',
                            action: 'View analytics',
                          ),

                          const SizedBox(height: 14),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: stats.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: mobile
                                  ? 1
                                  : tablet
                                      ? 2
                                      : 4,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: mobile
                                  ? 3.0
                                  : tablet
                                      ? 2.1
                                      : 1.35,
                            ),
                            itemBuilder: (context, index) {
                              return _ModernStatCard(
                                data: stats[index],
                              );
                            },
                          ),

                          const SizedBox(height: 30),

                          // ==================================================
                          // MINI INSIGHT BANNER
                          // ==================================================

                          _InsightBanner(),

                          const SizedBox(height: 30),

                          // ==================================================
                          // PROJECTS + ACTIVITY
                          // ==================================================

                          _SectionHeading(
                            title: 'Workspace',
                            action: 'View all',
                          ),

                          const SizedBox(height: 14),

                          if (mobile)
                            Column(
                              children: [
                                _ProjectsSection(
                                  projects: projects,
                                  columns: 1,
                                ),
                                const SizedBox(height: 20),
                                _ActivitySection(
                                  activities: activities,
                                ),
                              ],
                            )
                          else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: _ProjectsSection(
                                    projects: projects,
                                    columns: tablet ? 2 : 2,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: _ActivitySection(
                                    activities: activities,
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 30),
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
    );
  }
}

// ================================================================
// SIDEBAR
// ================================================================

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 235,
      color: AppColors.navy,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOGO

              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.auto_graph_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'NEXORA',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 42),

              const _SideItem(
                icon: Icons.grid_view_rounded,
                title: 'Dashboard',
                active: true,
              ),

              const _SideItem(
                icon: Icons.analytics_outlined,
                title: 'Analytics',
              ),

              const _SideItem(
                icon: Icons.shopping_bag_outlined,
                title: 'Orders',
              ),

              const _SideItem(
                icon: Icons.people_outline,
                title: 'Customers',
              ),

              const _SideItem(
                icon: Icons.inventory_2_outlined,
                title: 'Inventory',
              ),

              const _SideItem(
                icon: Icons.description_outlined,
                title: 'Reports',
              ),

              const Spacer(),

              const _SideItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.navyLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.indigo,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payal',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Administrator',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// SIDEBAR ITEM
// ================================================================

class _SideItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;

  const _SideItem({
    required this.icon,
    required this.title,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: active
            ? AppColors.indigo.withOpacity(0.18)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: active ? Colors.white : Colors.white54,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : Colors.white60,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// TOP BAR
// ================================================================

class _TopBar extends StatelessWidget {
  final bool mobile;

  const _TopBar({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 16 : 38,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          if (mobile)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 20,
              ),
            ),

          if (mobile) const SizedBox(width: 12),

          const Text(
            'Business Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 20,
              color: AppColors.text,
            ),
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.indigo,
            child: Icon(
              Icons.person,
              size: 19,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// SECTION HEADING
// ================================================================

class _SectionHeading extends StatelessWidget {
  final String title;
  final String action;

  const _SectionHeading({
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        const Spacer(),
        Text(
          action,
          style: const TextStyle(
            color: AppColors.indigo,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// STAT CARD
// ================================================================

class _ModernStatCard extends StatelessWidget {
  final StatData data;

  const _ModernStatCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final bool positive = data.change.startsWith('+');

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  data.icon,
                  color: data.color,
                  size: 21,
                ),
              ),
              const Spacer(),
              Icon(
                positive
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 14,
                color: positive
                    ? AppColors.green
                    : AppColors.red,
              ),
              const SizedBox(width: 3),
              Text(
                data.change,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: positive
                      ? AppColors.green
                      : AppColors.red,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            data.value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            data.title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// INSIGHT BANNER
// ================================================================

class _InsightBanner extends StatelessWidget {
  const _InsightBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.navy,
            AppColors.navyLight,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.indigo.withOpacity(0.25),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Great progress this month!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Revenue is performing 12% better than last month.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}

// ================================================================
// PROJECTS SECTION
// ================================================================

class _ProjectsSection extends StatelessWidget {
  final List<ProjectData> projects;
  final int columns;

  const _ProjectsSection({
    required this.projects,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        return _ProjectCard(
          data: projects[index],
        );
      },
    );
  }
}

// ================================================================
// PROJECT CARD
// ================================================================

class _ProjectCard extends StatelessWidget {
  final ProjectData data;

  const _ProjectCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (data.progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  data.icon,
                  color: data.color,
                  size: 19,
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.more_horiz,
                color: AppColors.muted,
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            data.team,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.muted,
            ),
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: data.progress,
                    minHeight: 7,
                    backgroundColor:
                        data.color.withOpacity(0.10),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(
                      data.color,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: data.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================================================================
// ACTIVITY SECTION
// ================================================================

class _ActivitySection extends StatelessWidget {
  final List<ActivityData> activities;

  const _ActivitySection({
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 18),

          ...activities.map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: activity.color.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      activity.icon,
                      size: 16,
                      color: activity.color,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          activity.time,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
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