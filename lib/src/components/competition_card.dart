import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/models/competition.dart';
import 'package:intl/intl.dart';

class CompetitionCard extends StatelessWidget {
  final Competition competition;

  const CompetitionCard({required this.competition});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMMM');
    String deadline = dateFormat.format(competition.deadline.toDate()); // Assuming deadline is a Timestamp
    String event = dateFormat.format(competition.event.toDate()); // Assuming event is a Timestamp
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/details/${competition.docId}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  competition.imageUrl,
                  width: 80.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      competition.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF165F23),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(children: [
                      if (competition.collegeStudent == true)
                        const Card(
                          color: Color(0XFF165F23),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Mahasiswa/i",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.0,
                              ),
                            ),
                          ),
                        ),
                      if (competition.hsStudent == true)
                        const Card(
                          color: Color(0XFF165F23),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "SMA/SMK",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.0,
                              ),
                            ),
                          ),
                        ),
                      if (competition.isFree == true)
                        const Card(
                          color: Color(0XFF165F23),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 6.0, bottom: 6.0),
                            child: Text(
                              "Gratis",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.0,
                              ),
                            ),
                          ),
                        ),
                    ]),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Text(
                          "Pendaftaran  ",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          deadline,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF165F23),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Event              ",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          event,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF165F23),
                          ),
                        ),
                      ],
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
