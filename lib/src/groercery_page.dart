import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:groercery/src/core/languages/translation.dart';

import 'providers/groercery_provider.dart';

class GroerceryPage extends StatefulWidget {
  const GroerceryPage({super.key});

  @override
  State<GroerceryPage> createState() => _GroerceryPageState();
}

class _GroerceryPageState extends State<GroerceryPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<GroerceryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(Translation.of(context).appTitle),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    controller: controller,
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    provider.addGroercery(controller.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Inserir'),
                )
              ],
            ),
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: provider,
        builder: (_, state, __) {
          if (state.isLoading || state.isInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) return const SizedBox();

          final groerceries = state.groerceries;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            itemCount: groerceries.length,
            itemBuilder: (_, i) {
              return Text(groerceries[i].name);
            },
          );
        },
      ),
    );
  }
}
