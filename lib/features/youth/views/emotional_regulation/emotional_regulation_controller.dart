import 'package:get/get.dart';

class Lesson {
  const Lesson(this.title, this.body);
  final String title;
  final String body;
}

class EmotionalRegulationController extends GetxController {
  static const weekLabel = 'Week 1:';
  static const dateRange = '23 Jan - 29 Jan';
  static const progress = .4;
  static const completedDays = 3;

  static const sectionTitle = 'Emotional identification lessons';
  static const goal =
      'Help youth accurately recognize, name, and describe emotions in themselves and others—building the foundation for regulation, communication, and empathy.';

  static const lessons = <Lesson>[
    Lesson(
      'Lesson 1: Understanding what emotions are',
      'In this lesson, youth are introduced to the idea that emotions are natural signals that help us understand what is happening inside us. Emotions are explained as messages rather than problems, helping youth see that feelings exist for a reason. Coaches guide youth in understanding that emotions are different from behaviors, and that feeling something strongly does not mean acting on it in a certain way. Through simple examples and personal reflection, youth begin to recognize that everyone experiences emotions, sometimes many in a single day.\nBy the end of this lesson, youth are able to describe emotions in their own words and understand that all emotions are acceptable and informative.',
    ),
    Lesson(
      'Lesson 2: Learning to name emotions',
      'This lesson focuses on building emotional vocabulary. Youth explore common emotions such as happiness, sadness, anger, fear, calmness, and excitement, learning how to correctly label what they are feeling in everyday situations. Coaches use stories, visuals, and real-life examples to help youth connect emotions to experiences they recognize.\nYouth practice identifying emotions in different scenarios, which helps reduce confusion and mislabeling. As their emotional vocabulary grows, they become more confident in talking about how they feel instead of acting it out.\nBy the end of this lesson, youth can accurately name basic emotions in themselves and others.',
    ),
    Lesson(
      'Lesson 3: Recognizing emotions in the body',
      'In this lesson, youth learn that emotions often show up physically before we fully recognize them mentally. Coaches help youth notice body signals such as changes in breathing, heart rate, muscle tension, or stomach sensations. Youth explore how different emotions feel in different parts of the body and learn that these signals can help them understand their feelings earlier.\nThrough guided discussion and body awareness activities, youth begin to connect physical sensations with emotional experiences. This awareness helps them pause and reflect before reacting.\nBy the end of this lesson, youth can identify at least one physical signal connected to an emotion they experience.',
    ),
    Lesson(
      'Lesson 4: Understanding emotional intensity',
      'This lesson introduces the idea that emotions can vary in strength. Youth learn that feelings are not just present or absent, but can exist at different intensity levels. Coaches explain the difference between mild emotions and overwhelming ones, using simple scales or metaphors to help youth understand emotional escalation.\nYouth practice identifying how strong an emotion feels and learn that recognizing intensity is an important step toward managing emotions safely. This lesson helps normalize big feelings while giving youth language to describe them more clearly.\nBy the end of this lesson, youth can describe whether an emotion feels small, medium, or big.',
    ),
    Lesson(
      'Lesson 5: Understanding emotions in others',
      'This lesson expands emotional identification beyond the self. Youth learn how to recognize emotions in others by observing facial expressions, tone of voice, and body language. Coaches guide youth through examples that show how people may feel differently in similar situations and that emotions are not always expressed the same way.\nYouth practice noticing emotional cues in peers and adults, helping them build empathy and social awareness. This lesson encourages curiosity rather than judgment when trying to understand others’ emotions.\nBy the end of this lesson, youth are better able to identify emotions in others and explain what clues helped them notice those feelings.',
    ),
    Lesson(
      'Lesson 6: Talking about feelings clearly',
      'In the final lesson, youth focus on expressing emotions in words. Coaches introduce simple sentence structures that help youth communicate how they feel and why, without blaming or shutting down. Youth practice sharing emotions in a respectful and safe way, learning that talking about feelings can reduce misunderstandings and emotional build-up.\nThis lesson reinforces the idea that expressing emotions is a skill that improves with practice. Youth leave with greater confidence in naming and sharing their feelings with trusted adults and peers.\nBy the end of this lesson, youth can clearly communicate at least one emotion using words instead of behavior.',
    ),
  ];

  /// Figma uses "capitalize" text: first letter of every word is upper-case.
  static String titleCase(String value) => value.replaceAllMapped(
        RegExp(r'(^|[\s\-—–])([a-z])'),
        (m) => '${m[1]}${m[2]!.toUpperCase()}',
      );
}
