enum PlantStage { seed, sprout, youngPlant, mature, flowering }

class PlantModel {
  final int day;
  final PlantStage stage;
  final String stageName;
  final int xp;
  final int maxXp;

  const PlantModel({
    required this.day,
    required this.stage,
    required this.stageName,
    required this.xp,
    required this.maxXp,
  });

  double get xpProgress => xp / maxXp;

  static const PlantModel sample = PlantModel(
    day: 42,
    stage: PlantStage.youngPlant,
    stageName: 'Young Plant',
    xp: 340,
    maxXp: 500,
  );
}

class GrowthMilestone {
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final bool isLocked;

  const GrowthMilestone({
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isLocked = false,
  });
}