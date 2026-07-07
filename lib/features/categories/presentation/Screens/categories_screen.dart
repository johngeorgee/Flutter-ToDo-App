// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/categories/presentation/providers/category_providers.dart';
const List<Color> categoryColors = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.yellow,
      Colors.green,
      Colors.teal,
      Colors.cyan,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.grey,
    ];
class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesStreamProvider);

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: categories.when(
        
        data: (list){
          if(list.isEmpty){
            return const Center(child: Text('No categories found'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              final category = list[index];
              return Card(
  margin: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 6,
  ),
  child: ListTile(
    leading: CircleAvatar(
      backgroundColor: category.color,
    ),
    title: Text(category.name),
    trailing: PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'delete') {
          await ref
              .read(categoryNotifierProvider.notifier)
              .delete(category.id);
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    ),
  ),
);
            },);
        }, 
        error: (e, _) => Center(
          child: Text('Error: ${e.toString()}'),
        ), 
        loading: () => const Center(
          child: CircularProgressIndicator(),
        )),
        floatingActionButton: FloatingActionButton(
          heroTag: "category_fab",
          onPressed: () {
            _showAddCategorySheet(context, ref);
          },
          child: const Icon(Icons.add_rounded),
          ),
    );
  }
}
Future<void> _showAddCategorySheet(
  BuildContext context,
  WidgetRef ref,
) async {
  final controller = TextEditingController();
  int selectedColor = categoryColors.first.value;
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState ){
          return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Category Name",
                ),
              ),
        
              const SizedBox(height: 20),
       

              Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categoryColors.map((color) {
                final selected = selectedColor == color.value;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color.value;
                    });
                  },
                  child: CircleAvatar(
                    radius: selected ? 18 : 15,
                    backgroundColor: color,
                    child: selected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          )
                        : null,
                  ),
                );
              }).toList(),
              ),

              const SizedBox(height: 20),
              FilledButton(
                onPressed: () async {
                  if (controller.text.trim().isEmpty) return;
        
                  await ref.read(categoryNotifierProvider.notifier).create(
                    name: controller.text.trim(),
                    colorValue:selectedColor,
                  );
        
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add Category"),
              ),
        
              const SizedBox(height: 20),
            ],
          ),
        );},
      );
    },
  );
}