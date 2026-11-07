import 'package:flutter/material.dart';

import '../../models/person_summary.dart';
import '../cards/person_summary_card.dart';

class PeopleList extends StatelessWidget {
  const PeopleList({
    required this.people,
    required this.onPersonTap,
    super.key,
  });

  final List<PersonSummary> people;
  final ValueChanged<PersonSummary> onPersonTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Center(
          child: Text(
            'Youths',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 20),
        ...people.map(
          (person) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PersonSummaryCard(
              person: person,
              showActions: false,
              onTap: () => onPersonTap(person),
            ),
          ),
        ),
      ],
    );
  }
}
