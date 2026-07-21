import 'package:flutter/material.dart';
import 'package:dacs/dacs.dart';

void main() => runApp(const DacsExampleApp());

class DacsExampleApp extends StatelessWidget {
  const DacsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DACS Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DACS Example'),
        centerTitle: true,
      ),
      body: ListView(
        padding: 'p-4'.dPads,
        children: [
          SectionHeader(title: 'Text Styles'),
          Text('Heading 2xl', style: 'text-2xl font-bold text-gray-900'.dText),
          SizedBox(height: 8),
          Text('Body medium', style: 'text-base font-medium text-gray-600'.dText),
          SizedBox(height: 8),
          Text('Small italic', style: 'text-sm italic text-sky-500'.dText),
          SizedBox(height: 8),
          Text(
            'Underline decoration',
            style: 'text-lg underline decoration-wavy decoration-sky-500'.dText,
          ),

          SectionHeader(title: 'Box Decoration'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-gradient-to-r from-sky-400 to-blue-600 rounded-xl shadow-lg'.dBox,
            child: Text(
              'Gradient card',
              style: 'text-white font-bold text-lg'.dText,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: 'px-4 py-3'.dPads,
            decoration: 'bg-white rounded-lg border border-gray-200 shadow-sm'.dBox,
            child: Text(
              'Bordered card with shadow',
              style: 'text-gray-700 text-base'.dText,
            ),
          ),

          SectionHeader(title: 'Dark / Light Mode'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-white dark:bg-gray-800 rounded-xl shadow'.dBoxOf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Toggle system theme to see variants in action.',
                  style: 'text-sm text-gray-500 dark:text-gray-400'.dTextOf(context),
                ),
                SizedBox(height: 8),
                Text(
                  'Title',
                  style: 'text-xl font-bold text-gray-900 dark:text-white'.dTextOf(context),
                ),
                SizedBox(height: 4),
                Text(
                  'This text adapts to dark and light mode automatically.',
                  style: 'text-base text-gray-600 dark:text-gray-300'.dTextOf(context),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Responsive'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-amber-50 dark:bg-amber-900 rounded-lg'.dBoxOf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resize the window to see responsive variants.',
                  style: 'text-xs text-amber-800 dark:text-amber-200'.dTextOf(context),
                ),
                SizedBox(height: 8),
                Text(
                  'Responsive heading',
                  style: 'text-base sm:text-lg md:text-xl lg:text-2xl'.dTextOf(context),
                ),
                SizedBox(height: 4),
                Text(
                  'This text grows as the screen gets wider.',
                  style: 'text-sm sm:text-base md:text-lg'.dTextOf(context),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Position (Stack)'),
          SizedBox(
            height: 100,
            child: Stack(
              children: [
                Container(decoration: 'bg-sky-100 rounded-lg'.dBox),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: 'px-3 py-1'.dPads,
                    decoration: 'bg-sky-500 rounded'.dBox,
                    child: Text(
                      'top-4 left-4',
                      style: 'text-white text-xs font-medium'.dText,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Container(
                    padding: 'px-3 py-1'.dPads,
                    decoration: 'bg-purple-500 rounded'.dBox,
                    child: Text(
                      'bottom-4 right-4',
                      style: 'text-white text-xs font-medium'.dText,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Transform'),
          Transform(
            transform: 'scale-125 rotate-12'.dTransform,
            child: Container(
              padding: 'px-4 py-2'.dPads,
              decoration: 'bg-green-500 rounded-lg'.dBox,
              child: Text(
                'Scaled & rotated',
                style: 'text-white font-bold'.dText,
              ),
            ),
          ),

          SectionHeader(title: 'Shadows'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ['shadow-sm', 'shadow', 'shadow-md', 'shadow-lg']
                .map((s) => Container(
                      width: 80,
                      height: 80,
                      decoration: 'bg-white $s rounded-lg'.dBox,
                      child: Center(child: Text(s, style: 'text-xs'.dText)),
                    ))
                .toList(),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: 'text-lg font-bold text-gray-800 dark:text-gray-200'.dTextOf(context),
      ),
    );
  }
}
