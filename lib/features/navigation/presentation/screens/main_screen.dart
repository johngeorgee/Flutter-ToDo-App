import 'package:flutter/material.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/features/categories/presentation/Screens/categories_screen.dart';
import 'package:todo_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/done_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens =  [
    const HomeScreen(),

    const Center(
      child: CategoriesScreen(),
    ),

    const Center(
      child: DoneScreen(),
    ),

   const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "main_fab",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addTask);
              },
              child:  const Icon(Icons.add_rounded)
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle()
        ,notchMargin: 8,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: Icons.home_outlined, 
                selectedIcon: Icons.home, 
                label: 'Tasks', 
                selected: _currentIndex == 0, 
                onTap: ()=> setState(() => _currentIndex = 0)),
              _NavItem(
                icon: Icons.folder_outlined, 
                selectedIcon: Icons.folder, 
                label: 'Categories', 
                selected: _currentIndex == 1, 
                onTap: ()=> setState(() => _currentIndex = 1)),
              _NavItem(
                icon: Icons.check_circle_outline, 
                selectedIcon: Icons.check_circle, 
                label: 'Done', 
                selected: _currentIndex == 2, 
                onTap: ()=> setState(() => _currentIndex = 2)),
                _NavItem(
                  icon: Icons.settings_outlined, 
                  selectedIcon: Icons.settings, 
                  label: 'Settings', 
                  selected: _currentIndex == 3, 
                  onTap: ()=> setState(() => _currentIndex = 3)),
            ],
          )


        ),
      )
    );
  }
}
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              color: selected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}