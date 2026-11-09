class SkillCategory {
  const SkillCategory({required this.name, required this.cropIndex});

  final String name;
  final int cropIndex;
}

class FeelingSkill {
  const FeelingSkill(this.title, this.description);

  final String title;
  final String description;
}

class FeelingInfo {
  const FeelingInfo({
    required this.title,
    required this.emojiAsset,
    required this.skills,
  });

  final String title;
  final String emojiAsset;
  final List<FeelingSkill> skills;
}

const feelingInfos = <FeelingInfo>[
  FeelingInfo(
    title: 'Feeling Anxious',
    emojiAsset: 'assets/emojis/1F630.svg',
    skills: [
      FeelingSkill('Box Breathing (4×4)',
          'Slow, Structured Breathing To Calm The Nervous System.'),
      FeelingSkill('Name 5 Things You Can See',
          'Gentle Grounding Through The Senses.'),
      FeelingSkill('Hand-On-Chest Breathing',
          'Encourages Safety And Self-Soothing.'),
      FeelingSkill('Temperature Reset',
          'Focus On Cool/Warm Sensations To Bring The Body Back To Now.'),
    ],
  ),
  FeelingInfo(
    title: 'Feeling Overwhelmed',
    emojiAsset: 'assets/emojis/1F629.svg',
    skills: [
      FeelingSkill('One-Minute Pause', 'Stop, Breathe, And Reduce Mental Noise.'),
      FeelingSkill('Break It Down',
          'Mentally Reduce Everything To One Small Next Step.'),
      FeelingSkill('Feet On The Floor Grounding',
          'Physical Anchoring To The Present Moment.'),
      FeelingSkill('Slow Counting Breath',
          'Extends The Exhale To Reduce Stress Response.'),
    ],
  ),
  FeelingInfo(
    title: 'Feeling Angry',
    emojiAsset: 'assets/emojis/1F620.svg',
    skills: [
      FeelingSkill('Release The Tension',
          'Clench And Release Muscles To Discharge Energy.'),
      FeelingSkill('Name The Feeling',
          'Quietly Label The Emotion Without Judgment.'),
      FeelingSkill('Cooling Breath',
          'Inhale Through Nose, Exhale Slowly Through Mouth.'),
      FeelingSkill('Step Back Visualization',
          'Imagine Stepping Away From The Situation For A Moment.'),
    ],
  ),
  FeelingInfo(
    title: 'Feeling Numb',
    emojiAsset: 'assets/emojis/1F611.svg',
    skills: [
      FeelingSkill('Temperature Awareness',
          'Notice Warmth Or Coolness Around You.'),
      FeelingSkill('Body Scan (Short)',
          'Gently Notice Sensations Without Changing Them.'),
      FeelingSkill('Name What You Can Hear',
          'Reconnect To The Environment Through Sound.'),
      FeelingSkill('Small Movement Reset',
          'Wiggle Fingers, Roll Shoulders, Notice Movement.'),
    ],
  ),
  FeelingInfo(
    title: 'Need To Calm Down',
    emojiAsset: 'assets/emojis/1F62E-200D-1F4A8.svg',
    skills: [
      FeelingSkill('Slow Breathing (2 Minutes)', 'Simple Rhythm-Based Calming.'),
      FeelingSkill('Safe Place Visualization',
          'Imagine A Place That Feels Neutral Or Safe.'),
      FeelingSkill('Guided Relaxation', 'Release Tension From Head To Toe.'),
      FeelingSkill('Quiet Focus Exercise',
          'Focus On One Neutral Object Or Sound.'),
    ],
  ),
];
