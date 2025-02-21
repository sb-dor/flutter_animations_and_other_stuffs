// remember that every widget has it's own sizedBox with height,
// in order to figure it out in which position is specific widget to make calculation
// and animate positioned widget in stack widget
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/auto_comparison_widget/auto_comparison_controller.dart';
import 'package:flutter_animations_2/auto_comparison_widget/listview_model.dart';
import 'package:flutter_animations_2/widgets/text_widget.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class ComparisonsDetails extends StatefulWidget {
  //
  const ComparisonsDetails({super.key});

  @override
  State<ComparisonsDetails> createState() => _ComparisonsDetailsState();
}

class _ComparisonsDetailsState extends State<ComparisonsDetails> {
  static const double _kButtonsHeight = 40.0;
  static const double _kDividerHeight = 16.0;
  late final PageController _pageController;
  late final LinkedScrollControllerGroup _linkedScrollControllerGroup;
  final List<ScrollController> _scrollControllers = [];
  late final AutoComparisonController _autoComparisonController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5);
    _linkedScrollControllerGroup = LinkedScrollControllerGroup();
    for (int i = 0; i < ListViewModel.comparisons.length; i++) {
      final scrollController = _linkedScrollControllerGroup.addAndGet();
      _scrollControllers.add(scrollController);
    }
    _autoComparisonController = AutoComparisonController(
      scrollControllerGroup: _linkedScrollControllerGroup,
      pageController: _pageController,
    );
  }

  @override
  void dispose() {
    for (final each in _scrollControllers) {
      each.dispose();
    }
    _autoComparisonController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: "Сравнение",
              size: 24,
              fontWeight: FontWeight.bold,
            ),
            TextWidget(
              text: "${ListViewModel.comparisons.length} объявления",
              size: 13,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                pageSnapping: true,
                padEnds: false,
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: ListViewModel.comparisons.length,
                itemBuilder: (context, index) {
                  final comparison = ListViewModel.comparisons[index];
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: ClampingScrollPhysics(),
                      ),
                      controller: _scrollControllers[index],
                      children: [
                        SizedBox(
                          height: 135,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: const Placeholder(),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Center(
                                    child: IconButton(
                                      padding: const EdgeInsets.all(6),
                                      constraints: const BoxConstraints(),
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          Colors.black.withValues(alpha: 0.4),
                                        ),
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: TextWidget(
                            text: comparison.title,
                            size: 16,
                            fontWeight: FontWeight.bold,
                            maxLines: 3,
                            overFlow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: _kButtonsHeight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: const WidgetStatePropertyAll(
                                Colors.green,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Center(
                              child: Text(
                                "Показать телефон",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: _kDividerHeight),
                        // Цена
                        const SizedBox(height: 65),
                        TextWidget(
                          text: comparison.price,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Пробег
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.mileage,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Состояние
                        const SizedBox(height: 25),
                        const TextWidget(
                          text: "Good",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Цвет
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.color,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Таможня
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.condition,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Объем
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.engineVolume,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Двигатель
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.engineType,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // Мощность
                        const SizedBox(height: 25),
                        const TextWidget(
                          text: "100 Horse speed",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: _kDividerHeight),
                        // if (!_startedToScrollPageView && _pageController.page?.toInt() == index)
                        //   const SizedBox(
                        //     height: 20,
                        //     child: Text("Scrolling"),
                        //   ),
                        const SizedBox(height: 100),
                        ...List.generate(
                          100,
                          (i) => Text("Number: ${i + 1}"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Характеристики
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (205 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Характеристики",
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (250 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Цена",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (310 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Пробег",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (375 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Состояние",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (440 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Цвет",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (505 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Таможня",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (570 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Объем",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (635 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Двигатель",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _autoComparisonController,
              builder: (context, child) {
                return Positioned(
                  top: (700 + _kButtonsHeight + _kDividerHeight) -
                      _autoComparisonController.scrollingTextOffset,
                  left: 5,
                  child: const SizedBox(
                    height: 30,
                    child: TextWidget(
                      text: "Мощность",
                      size: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextModel {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overFlow;

  TextModel({
    required this.text,
    this.size = 16,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines,
    this.overFlow,
  });
}
