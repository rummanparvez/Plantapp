import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plant_identification_app/models/plant.dart';
import 'package:plant_identification_app/screens/care/plant_care_screen.dart';
import 'package:plant_identification_app/theme/app_theme.dart';

class IdentifyResultScreen extends StatefulWidget {
  final String? imagePath;
  
  const IdentifyResultScreen({
    super.key,
    this.imagePath,
  });

  @override
  State<IdentifyResultScreen> createState() => _IdentifyResultScreenState();
}

class _IdentifyResultScreenState extends State<IdentifyResultScreen> {
  late Future<Plant> _plantFuture;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    if (widget.imagePath != null) {
      // In a real app, you would call an API to identify the plant
      // For demo purposes, we'll simulate an API call with a delay
      _plantFuture = _identifyPlant();
    }
  }
  
  Future<Plant> _identifyPlant() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
    
    // Return a mock plant result
    return Plant(
      id: '1',
      commonName: 'Monstera Deliciosa',
      scientificName: 'Monstera deliciosa',
      family: 'Araceae',
      description: 'The Monstera deliciosa is a species of flowering plant native to tropical forests of southern Mexico, south to Panama. It has been introduced to many tropical areas, and has become a mildly invasive species in Hawaii, Seychelles, Ascension Island and the Society Islands.',
      careInstructions: const {
        'light': 'Bright, indirect light',
        'water': 'Allow soil to dry out between waterings',
        'humidity': 'Prefers high humidity',
        'temperature': '65-85°F (18-29°C)',
        'soil': 'Well-draining potting mix',
        'fertilizer': 'Monthly during growing season',
      },
      imageUrl: widget.imagePath ?? '',
      probability: 0.95,
      similarPlants: [
        'Monstera Adansonii',
        'Philodendron Bipinnatifidum',
        'Rhaphidophora Tetrasperma',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePath == null) {
      return _buildEmptyState();
    }
    
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? _buildLoadingUI()
            : FutureBuilder<Plant>(
                future: _plantFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingUI();
                  }
                  
                  if (snapshot.hasError) {
                    return _buildErrorUI(snapshot.error.toString());
                  }
                  
                  if (snapshot.hasData) {
                    return _buildResultUI(snapshot.data!);
                  }
                  
                  return _buildEmptyState();
                },
              ),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Identifying your plant...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'This may take a moment',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
          ),
          if (widget.imagePath != null) ...[
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.file(
                  File(widget.imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorUI(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppTheme.errorColor,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Identification Failed',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We couldn\'t identify your plant. Please try again with a clearer image.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('TRY AGAIN'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultUI(Plant plant) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plant image and basic info
          Stack(
            children: [
              // Plant image
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.file(
                  File(widget.imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
              
              // Back button
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              
              // Gradient overlay for text
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${(plant.probability * 100).toInt()}% Match',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        plant.commonName,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        plant.scientificName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Plant details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                _buildSectionHeading('About'),
                const SizedBox(height: 8),
                Text(
                  plant.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),
                const SizedBox(height: 24),
                
                // Care overview
                _buildSectionHeading('Care Overview'),
                const SizedBox(height: 12),
                _buildCareGrid(plant.careInstructions),
                const SizedBox(height: 24),
                
                // View detailed care button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantCareScreen(plant: plant),
                        ),
                      );
                    },
                    icon: const Icon(Icons.water_drop),
                    label: const Text('VIEW DETAILED CARE GUIDE'),
                  ),
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 24),
                
                // Similar plants
                _buildSectionHeading('Similar Plants'),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: plant.similarPlants.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              plant.similarPlants[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: Duration(milliseconds: 200 * index));
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ).animate().fadeIn(delay: 100.ms);
  }

  Widget _buildCareGrid(Map<String, String> careInstructions) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: careInstructions.length,
      itemBuilder: (context, index) {
        final key = careInstructions.keys.elementAt(index);
        final value = careInstructions[key]!;
        
        IconData iconData;
        switch (key.toLowerCase()) {
          case 'light':
            iconData = Icons.wb_sunny_outlined;
            break;
          case 'water':
            iconData = Icons.water_drop_outlined;
            break;
          case 'humidity':
            iconData = Icons.water_outlined;
            break;
          case 'temperature':
            iconData = Icons.thermostat_outlined;
            break;
          case 'soil':
            iconData = Icons.landscape_outlined;
            break;
          case 'fertilizer':
            iconData = Icons.eco_outlined;
            break;
          default:
            iconData = Icons.info_outline;
        }
        
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    key.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 200 * index)).moveY(begin: 10, end: 0);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.eco_outlined,
              color: AppTheme.primaryColor,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Identify Plants',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Take a photo of a plant to identify it and get care instructions.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to camera screen
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('TAKE A PHOTO'),
            ),
          ],
        ),
      ),
    );
  }
}