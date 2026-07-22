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
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  final _cardGroup = DacsStyle.apply('rounded-xl shadow-md p-4 bg-white');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final begin = DacsStyle()..opacity = 1;
    final end = DacsStyle()..opacity = 0.3;
    final animated = _controller.dAnimated(begin, end);

    return Scaffold(
      appBar: AppBar(title: const Text('DACS Example'), centerTitle: true),
      body: ListView(
        padding: 'p-4'.dPads,
        children: [
          SectionHeader(title: 'Text Styles'),
          Text('Heading 2xl', style: 'text-2xl font-bold text-gray-900'.dText),
          const SizedBox(height: 8),
          Text(
            'Body medium',
            style: 'text-base font-medium text-gray-600'.dText,
          ),
          const SizedBox(height: 8),
          Text('Small italic', style: 'text-sm italic text-sky-500'.dText),
          const SizedBox(height: 8),
          Text(
            'Underline decoration',
            style: 'text-lg underline decoration-wavy decoration-sky-500'.dText,
          ),

          SectionHeader(title: 'Theme Colors'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-primaryContainer rounded-lg'.dBoxOf(context),
            child: Text(
              'Uses ColorScheme (primaryContainer)',
              style: 'text-onPrimaryContainer font-medium'.dTextOf(context),
            ),
          ),

          SectionHeader(title: 'Arbitrary Values'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-[#ff00ff] rounded-[16]'.dBox,
            child: const Text(
              'Custom hex bg + 16px radius',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SectionHeader(title: 'Apply (Reusable Groups)'),
          Container(
            padding: 'p-4'.dPads,
            decoration: _cardGroup.toBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card style via apply()',
                  style: 'text-lg font-bold'.dText,
                ),
                const SizedBox(height: 4),
                Text(
                  'DacsStyle.apply("rounded-xl shadow-md p-4 bg-white")',
                  style: 'text-sm text-gray-500'.dText,
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Gap & Flex Helpers'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-gray-50 dark:bg-gray-800 rounded-lg'.dBoxOf(
              context,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flex row with gap-3',
                  style: 'text-sm font-medium text-gray-600 dark:text-gray-300'
                      .dTextOf(context),
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: DacsStyle.apply('gap-3').gap ?? 12,
                  children: [1, 2, 3].map((i) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: 'bg-primary rounded-lg'.dBoxOf(context),
                      child: Center(
                        child: Text(
                          '$i',
                          style: 'text-white font-bold text-xl'.dText,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Text(
                  'items-center + justify-between',
                  style: 'text-sm font-medium text-gray-600 dark:text-gray-300'
                      .dTextOf(context),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: 'p-3'.dPads,
                  decoration: 'bg-white dark:bg-gray-700 rounded-lg'.dBoxOf(
                    context,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Left', style: 'font-medium'.dText),
                      Text('Center', style: 'text-gray-500'.dText),
                      Text('Right', style: 'font-medium'.dText),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Box Decoration'),
          Container(
            padding: 'p-4'.dPads,
            decoration:
                'bg-gradient-to-r from-sky-400 to-blue-600 rounded-xl shadow-lg'
                    .dBox,
            child: Text(
              'Gradient card',
              style: 'text-white font-bold text-lg'.dText,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: 'px-4 py-3'.dPads,
            decoration:
                'bg-white rounded-lg border border-gray-200 shadow-sm'.dBox,
            child: Text(
              'Bordered card with shadow',
              style: 'text-gray-700 text-base'.dText,
            ),
          ),

          SectionHeader(title: 'Material Widget Extensions'),
          ElevatedButton(
            style: 'bg-primary text-white rounded-lg'.dButton(context),
            onPressed: () {},
            child: const Text('Styled Button'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: 'bg-primary text-white rounded-lg w-48'.dButton(context),
            child: const Text('Fixed width via w-48'),
          ),
          const SizedBox(height: 8),
          CheckboxTheme(
            data: 'checked:bg-primary unchecked:bg-surface'.dCheckbox(context),
            child: Checkbox(value: true, onChanged: (_) {}),
          ),

          SectionHeader(title: 'TextField InputDecoration'),
          TextField(
            style: 'text-onSurface'.dTextOf(context),
            decoration:
                ('label-[Email] hint-[you@example.com] '
                        'helper-[TextField.style handles typed text; '
                        'dInputOf handles decoration.] '
                        'filled dense bg-surface border-outline '
                        'focus:border-primary disabled:border-outlineVariant '
                        'error:border-error focus:error:border-primaryContainer '
                        'rounded-lg p-4')
                    .dInputOf(context),
          ),
          const SizedBox(height: 8),
          TextField(
            enabled: false,
            style: 'text-onSurfaceVariant'.dTextOf(context),
            decoration:
                'label-[Disabled] hint-[Native disabledBorder] filled dense '
                        'bg-surfaceVariant border-outline disabled:border-error '
                        'rounded-lg p-4'
                    .dInputOf(context),
          ),

          SectionHeader(title: 'Date / Time Picker Themes'),
          Theme(
            data: Theme.of(context).copyWith(
              datePickerTheme:
                  ('bg-surface text-onSurface rounded-lg shadow-md '
                          'date-header-bg-primary date-header-text-onPrimary '
                          'date-day-text-onSurface selected:date-day-bg-primary '
                          'hover:date-day-overlay-secondary '
                          'date-today-text-secondary date-divider-outline')
                      .dDatePicker(context),
              timePickerTheme:
                  ('bg-surface text-onSurface rounded-lg shadow-md p-4 '
                          'time-dial-bg-surfaceVariant time-dial-hand-primary '
                          'time-hour-minute-bg-surfaceVariant '
                          'selected:time-hour-minute-bg-secondary '
                          'time-hour-minute-text-onSurface '
                          'selected:time-hour-minute-text-onSecondary '
                          'time-separator-outline')
                      .dTimePicker(context),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  style: 'bg-primary text-onPrimary rounded-lg'.dButton(
                    context,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now(),
                    );
                  },
                  child: const Text('Open date picker'),
                ),
                ElevatedButton(
                  style: 'bg-secondary text-onSecondary rounded-lg'.dButton(
                    context,
                  ),
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: const Text('Open time picker'),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Dark / Light Mode'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-white dark:bg-gray-800 rounded-xl shadow'.dBoxOf(
              context,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Toggle system theme to see variants in action.',
                  style: 'text-sm text-gray-500 dark:text-gray-400'.dTextOf(
                    context,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Title',
                  style: 'text-xl font-bold text-gray-900 dark:text-white'
                      .dTextOf(context),
                ),
                const SizedBox(height: 4),
                Text(
                  'This text adapts to dark and light mode automatically.',
                  style: 'text-base text-gray-600 dark:text-gray-300'.dTextOf(
                    context,
                  ),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'WidgetState & Chained Variants'),
          ElevatedButton(
            style:
                ('bg-primary hover:bg-primaryContainer '
                        'disabled:bg-surface '
                        'rounded-lg hover:rounded-xl')
                    .dButton(context),
            onPressed: () {},
            child: const Text('Hover shape: rounded-xl'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: 'bg-primary dark:hover:bg-error'.dButton(context),
            onPressed: () {},
            child: const Text('Dark + Hover (chained)'),
          ),

          SectionHeader(title: 'Important (!)'),
          Text(
            'This ignores dark mode override',
            style: 'text-base text-red-500! dark:text-blue-300'.dTextOf(
              context,
            ),
          ),

          SectionHeader(title: 'Overflow'),
          Container(
            height: 60,
            decoration: 'bg-gray-100 dark:bg-gray-800 rounded-lg'.dBoxOf(
              context,
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: 'bg-red-300 rounded'.dBox,
                  child: const Center(child: Text('Overflow')),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'Responsive'),
          Container(
            padding: 'p-4'.dPads,
            decoration: 'bg-amber-50 dark:bg-amber-900 rounded-lg'.dBoxOf(
              context,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resize the window to see responsive variants.',
                  style: 'text-xs text-amber-800 dark:text-amber-200'.dTextOf(
                    context,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Responsive heading',
                  style: 'text-base sm:text-lg md:text-xl lg:text-2xl'.dTextOf(
                    context,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This text grows as the screen gets wider.',
                  style: 'text-sm sm:text-base md:text-lg'.dTextOf(context),
                ),
              ],
            ),
          ),

          SectionHeader(title: 'RTL Border Radius'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _radiusBox('rounded-ts-lg'),
              _radiusBox('rounded-te-lg'),
              _radiusBox('rounded-be-lg'),
              _radiusBox('rounded-bs-lg'),
            ],
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

          SectionHeader(title: 'Animated (pulsing opacity)'),
          AnimatedBuilder(
            animation: animated,
            builder: (context, child) {
              final s = animated.value;
              return Opacity(
                opacity: s.opacity ?? 1,
                child: Container(
                  padding: 'px-4 py-2'.dPads,
                  decoration: 'bg-purple-500 rounded-lg'.dBox,
                  child: const Text(
                    'Pulsing',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),

          SectionHeader(title: 'Shadows'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ['shadow-sm', 'shadow', 'shadow-md', 'shadow-lg']
                .map(
                  (s) => Container(
                    width: 80,
                    height: 80,
                    decoration: 'bg-white $s rounded-lg'.dBox,
                    child: Center(child: Text(s, style: 'text-xs'.dText)),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _radiusBox(String cls) {
    return Container(
      width: 80,
      height: 60,
      decoration: 'bg-teal-100 $cls border border-teal-300'.dBox,
      child: Center(
        child: Text(cls, style: 'text-[10px] text-teal-800 font-medium'.dText),
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
        style: 'text-lg font-bold text-gray-800 dark:text-gray-200'.dTextOf(
          context,
        ),
      ),
    );
  }
}
