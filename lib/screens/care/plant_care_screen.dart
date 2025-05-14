import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_identification_app/models/plant.dart';
import 'package:plant_identification_app/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlantCareScreen extends StatefulWidget {
  final Plant plant;

  const PlantCareScreen({
    super.key,
    required this.plant,
  });

  @override
  State<PlantCareScreen> createState() => _PlantCareScreenState();
}

class _PlantCareScreenState extends State<PlantCareScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 240.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.plant.commonName),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Plant image
                    if (widget.plant.imageUrl.isNotEmpty)
                      Image.file(
                        File(widget.plant.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    
                    // Gradient overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Save to favorites
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Share functionality
                  },
                ),
              ],
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppTheme.primaryColor,
                  unselectedLabelColor: AppTheme.secondaryTextColor,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.water_drop_outlined),
                      text: 'CARE',
                    ),
                    Tab(
                      icon: Icon(Icons.info_outline),
                      text: 'ABOUT',
                    ),
                    Tab(
                      icon: Icon(Icons.history_outlined),
                      text: 'HISTORY',
                    ),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildCareTab(),
            _buildAboutTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCareTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeading('Care Instructions'),
          const SizedBox(height: 16),
          
          // Watering
          _buildCareItem(
            title: 'Watering',
            description: widget.plant.careInstructions['water'] ?? 'No information available',
            icon: Icons.water_drop_outlined,
            color: Colors.blue.shade300,
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          
          // Light
          _buildCareItem(
            title: 'Light',
            description: widget.plant.careInstructions['light'] ?? 'No information available',
            icon: Icons.wb_sunny_outlined,
            color: Colors.amber.shade300,
          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          
          // Humidity
          _buildCareItem(
            title: 'Humidity',
            description: widget.plant.careInstructions['humidity'] ?? 'No information available',
            icon: Icons.water_outlined,
            color: Colors.cyan.shade300,
          ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          
          // Temperature
          _buildCareItem(
            title: 'Temperature',
            description: widget.plant.careInstructions['temperature'] ?? 'No information available',
            icon: Icons.thermostat_outlined,
            color: Colors.orange.shade300,
          ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          
          // Soil
          _buildCareItem(
            title: 'Soil',
            description: widget.plant.careInstructions['soil'] ?? 'No information available',
            icon: Icons.landscape_outlined,
            color: Colors.brown.shade300,
          ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 16),
          
          // Fertilizer
          _buildCareItem(
            title: 'Fertilizer',
            description: widget.plant.careInstructions['fertilizer'] ?? 'No information available',
            icon: Icons.eco_outlined,
            color: Colors.green.shade300,
          ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 32),
          
          // Care tips
          _buildSectionHeading('Seasonal Care'),
          const SizedBox(height: 16),
          
          _buildSeasonalCare(),
          const SizedBox(height: 32),
          
          // Set reminders
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Add care reminder functionality
              },
              icon: const Icon(Icons.add_alert),
              label: const Text('SET CARE REMINDERS'),
            ),
          ).animate().fadeIn(delay: 800.ms),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plant details
          _buildSectionHeading('Plant Details'),
          const SizedBox(height: 16),
          
          ListTile(
            title: const Text('Common Name'),
            subtitle: Text(widget.plant.commonName),
            leading: const Icon(Icons.label_outline, color: AppTheme.primaryColor),
            contentPadding: EdgeInsets.zero,
          ).animate().fadeIn(delay: 100.ms),
          
          const Divider(),
          
          ListTile(
            title: const Text('Scientific Name'),
            subtitle: Text(
              widget.plant.scientificName,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            leading: const Icon(Icons.science_outlined, color: AppTheme.primaryColor),
            contentPadding: EdgeInsets.zero,
          ).animate().fadeIn(delay: 200.ms),
          
          const Divider(),
          
          ListTile(
            title: const Text('Family'),
            subtitle: Text(widget.plant.family),
            leading: const Icon(Icons.account_tree_outlined, color: AppTheme.primaryColor),
            contentPadding: EdgeInsets.zero,
          ).animate().fadeIn(delay: 300.ms),
          
          const SizedBox(height: 32),
          
          // Description
          _buildSectionHeading('Description'),
          const SizedBox(height: 16),
          
          Text(
            widget.plant.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ).animate().fadeIn(delay: 400.ms),
          
          const SizedBox(height: 32),
          
          // Growth characteristics
          _buildSectionHeading('Growth Characteristics'),
          const SizedBox(height: 16),
          
          _buildGrowthCharacteristics(),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.history_outlined,
            size: 80,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'No History Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Add this plant to your collection to start tracking care history.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.secondaryTextColor,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Add to collection
            },
            icon: const Icon(Icons.add),
            label: const Text('ADD TO MY PLANTS'),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildSectionHeading(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCareItem({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalCare() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSeasonRow(
            'Spring',
            'Increase watering as growth resumes. Apply fertilizer monthly.',
            Colors.green.shade300,
          ),
          const Divider(height: 32),
          _buildSeasonRow(
            'Summer',
            'Water regularly and monitor for pests. Provide shade from intense heat.',
            Colors.red.shade300,
          ),
          const Divider(height: 32),
          _buildSeasonRow(
            'Fall',
            'Reduce watering and fertilizer as growth slows. Prepare for dormancy.',
            Colors.orange.shade300,
          ),
          const Divider(height: 32),
          _buildSeasonRow(
            'Winter',
            'Minimal watering. Keep away from cold drafts and heating sources.',
            Colors.blue.shade300,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms);
  }

  Widget _buildSeasonRow(String season, String care, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            season,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            care,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildGrowthCharacteristics() {
    // This would typically come from the plant data
    const growthData = {
      'Growth Rate': 'Moderate',
      'Mature Size': '2-3 feet tall, 2-3 feet wide',
      'Light Tolerance': 'Tolerates low light, prefers bright indirect light',
      'Special Features': 'Air-purifying, distinctive leaf pattern',
    };
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: growthData.entries.map((entry) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      entry.key,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              if (entry != growthData.entries.last)
                const Divider(height: 24),
            ],
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 500.ms);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.darkBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}