import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.blue[900]!, Colors.blue[800]!]
                    : [Colors.blue[700]!, Colors.blue[600]!],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Biruu',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Feather.message_circle,
                      color: isDark ? Colors.white : Colors.blue[700]),
                  title: Text(
                    'Chat',
                    style: GoogleFonts.poppins(),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                ListTile(
                  leading: Icon(Feather.calendar,
                      color: isDark ? Colors.white : Colors.blue[700]),
                  title: Text(
                    'Calendar',
                    style: GoogleFonts.poppins(),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
                ListTile(
                  leading: Icon(Feather.clock,
                      color: isDark ? Colors.white : Colors.blue[700]),
                  title: Text(
                    'Schedule',
                    style: GoogleFonts.poppins(),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/schedule');
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: isDark ? Colors.grey[800] : Colors.grey[300],
            height: 1,
          ),
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: GoogleFonts.poppins(),
            ),
            value: isDark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}