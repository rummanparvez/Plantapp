import 'package:flutter/material.dart';
import 'package:plant_identification_app/models/plant.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plant_identification_app/theme/app_theme.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final plants = [
      Plant(
        id: '1',
        commonName: 'Monstera Deliciosa',
        scientificName: 'Monstera deliciosa',
        family: 'Araceae',
        description: 'The Monstera deliciosa is a species of flowering plant native to tropical forests of southern Mexico, south to Panama.',
        careInstructions: const {
          'light': 'Bright, indirect light',
          'water': 'Allow soil to dry out between waterings',
          'humidity': 'Prefers high humidity',
          'temperature': '65-85°F (18-29°C)',
          'soil': 'Well-draining potting mix',
          'fertilizer': 'Monthly during growing season',
        },
        imageUrl: '',
        probability: 0.95,
        similarPlants: [],
      ),
      Plant(
        id: '2',
        commonName: 'Snake Plant',
        scientificName: 'Sansevieria trifasciata',
        family: 'Asparagaceae',
        description: 'The snake plant, also known as mother-in-law\'s tongue, is one of the most tolerant houseplants you can find.',
        careInstructions: const {
          'light': 'Low to bright indirect light',
          'water': 'Allow soil to dry completely between waterings',
          'humidity': 'Tolerates low humidity',
          'temperature': '70-90°F (21-32°C)',
          'soil': 'Well-draining, sandy soil',
          'fertilizer': 'Sparingly, 2-3 times a year',
        },
        imageUrl: '',
        probability: 0.92,
        similarPlants: [],
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text('Plant Care'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's tasks
            Text(
              'Today\'s Care Tasks',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(),
            const SizedBox(height: 16),
            _buildCareTasksList(),
            const SizedBox(height: 32),
            
            // Your plants
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Plants',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // View all plants
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('See All'),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 16),
            _buildPlantsList(plants, context),
            const SizedBox(height: 32),
            
            // Care guide
            Text(
              'Care Guides',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 600.ms),
            const SizedBox(height: 16),
            _buildCareGuidesList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCareTasksList() {
    return Column(
      children: [
        // Water task
        _CareTaskCard(
          icon: Icons.water_drop,
          title: 'Water your Monstera',
          subtitle: 'Last watered 7 days ago',
          color: Colors.blue.shade300,
          onTap: () {},
        ).animate().fadeIn(delay: 100.ms).moveX(begin: -20, end: 0),
        const SizedBox(height: 12),
        
        // Fertilize task
        _CareTaskCard(
          icon: Icons.eco,
          title: 'Fertilize your Ficus',
          subtitle: 'Last fertilized 30 days ago',
          color: Colors.green.shade300,
          onTap: () {},
        ).animate().fadeIn(delay: 200.ms).moveX(begin: -20, end: 0),
        const SizedBox(height: 12),
        
        // Rotate task
        _CareTaskCard(
          icon: Icons.rotate_right,
          title: 'Rotate your Pothos',
          subtitle: 'Last rotated 14 days ago',
          color: Colors.amber.shade300,
          onTap: () {},
        ).animate().fadeIn(delay: 300.ms).moveX(begin: -20, end: 0),
      ],
    );
  }

  Widget _buildPlantsList(List<Plant> plants, BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plants.length + 1,
        itemBuilder: (context, index) {
          if (index == plants.length) {
            // Add new plant card
            return Container(
              margin: const EdgeInsets.only(right: 16),
              width: 180,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 48,
                    color: AppTheme.primaryColor.withOpacity(0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Add New Plant',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: Duration(milliseconds: 100 * (index + 1)));
          }
          
          final plant = plants[index];
          
          return Container(
            margin: const EdgeInsets.only(right: 16),
            width: 180,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plant image placeholder
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.eco,
                      size: 48,
                      color: AppTheme.primaryColor.withOpacity(0.7),
                    ),
                  ),
                ),
                
                // Plant info
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.commonName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        plant.scientificName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppTheme.secondaryTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      _buildCareIndicator(
                        'Water',
                        0.3,
                        Colors.blue.shade300,
                        context,
                      ),
                      const SizedBox(height: 8),
                      _buildCareIndicator(
                        'Light',
                        0.7,
                        Colors.amber.shade300,
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 100 * (index + 1)));
        },
      ),
    );
  }

  Widget _buildCareIndicator(String label, double value, Color color, BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: AppTheme.darkBackgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCareGuidesList() {
    return Column(
      children: [
        _CareGuideCard(
          title: 'Watering Guide',
          subtitle: 'Learn the best practices for watering different plants',
          icon: Icons.water_drop_outlined,
          onTap: () {},
        ).animate().fadeIn(delay: 700.ms).moveY(begin: 20, end: 0),
        const SizedBox(height: 12),
        _CareGuideCard(
          title: 'Light Requirements',
          subtitle: 'How to provide the right light for your plants',
          icon: Icons.wb_sunny_outlined,
          onTap: () {},
        ).animate().fadeIn(delay: 800.ms).moveY(begin: 20, end: 0),
        const SizedBox(height: 12),
        _CareGuideCard(
          title: 'Plant Propagation',
          subtitle: 'Step-by-step guides to grow more plants',
          icon: Icons.spa_outlined,
          onTap: () {},
        ).animate().fadeIn(delay: 900.ms).moveY(begin: 20, end: 0),
      ],
    );
  }
}

class _CareTaskCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _CareTaskCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppTheme.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
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
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppTheme.secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CareGuideCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _CareGuideCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppTheme.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
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
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.secondaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppTheme.secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}