// remember that every widget has it's own sizedBox with height,
// in order to figure it out in which position is specific widget to make calculation
// and animate positioned widget in stack widget
//
// was created changeNotifiers
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/auto_comparison_widget/controllers/auto_comparison_controller.dart';
import 'package:flutter_animations_2/auto_comparison_widget/controllers/auto_comparison_topbar_controller.dart';
import 'package:flutter_animations_2/auto_comparison_widget/models/listview_model.dart';
import 'package:flutter_animations_2/widgets/text_widget.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'animted_comparison_tombar.dart';

const double kButtonsHeight = 40.0;
const double kDividerHeight = 16.0;

class ComparisonsDetails extends StatefulWidget {
  //
  const ComparisonsDetails({super.key});

  @override
  State<ComparisonsDetails> createState() => _ComparisonsDetailsState();
}

class _ComparisonsDetailsState extends State<ComparisonsDetails> {
  late final PageController _pageController;
  late final LinkedScrollControllerGroup _linkedScrollControllerGroup;
  final List<ScrollController> _scrollControllers = [];
  late final AutoComparisonController _autoComparisonController;
  late final AutoComparisonTopBarController _autoComparisonTopBarController;

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
    _autoComparisonTopBarController = AutoComparisonTopBarController(
      pageController: _pageController,
    );
  }

  @override
  void dispose() {
    for (final each in _scrollControllers) {
      each.dispose();
    }
    _autoComparisonController.dispose();
    _autoComparisonTopBarController.dispose();
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
                          height: kButtonsHeight,
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
                        const Divider(height: kDividerHeight),
                        // Цена
                        const SizedBox(height: 65),
                        TextWidget(
                          text: comparison.price,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Пробег
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.mileage,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Состояние
                        const SizedBox(height: 25),
                        const TextWidget(
                          text: "Good",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Цвет
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.color,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Таможня
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.condition,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Объем
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.engineVolume,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Двигатель
                        const SizedBox(height: 25),
                        TextWidget(
                          text: comparison.engineType,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
                        // Мощность
                        const SizedBox(height: 25),
                        const TextWidget(
                          text: "100 Horse speed",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(height: kDividerHeight),
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
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Характеристики",
              heightFrom: 205,
              textSize: 20,
              fontWeight: FontWeight.bold,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Цена",
              heightFrom: 250,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Пробег",
              heightFrom: 310,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Состояние",
              heightFrom: 375,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Цвет",
              heightFrom: 440,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Таможня",
              heightFrom: 505,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Объем",
              heightFrom: 570,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Двигатель",
              heightFrom: 635,
            ),
            _FixedScrollText(
              comparisonScrollController: _autoComparisonController,
              title: "Мощность",
              heightFrom: 700,
            ),
            ...ListViewModel.comparisons.mapIndexed(
              (index, comparison) => AnimatedComparisonTopBar(
                autoComparisonController: _autoComparisonController,
                autoComparisonTopBarController: _autoComparisonTopBarController,
                comparison: comparison,
                index: index,
                screenWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FixedScrollText extends StatelessWidget {
  //
  const _FixedScrollText({
    required this.comparisonScrollController,
    required this.title,
    required this.heightFrom,
    this.textSize = 16,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
  });

  final AutoComparisonController comparisonScrollController;
  final String title;
  final double heightFrom;
  final double textSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: comparisonScrollController,
      builder: (context, child) {
        return Positioned(
          top: (heightFrom + kButtonsHeight + kDividerHeight) -
              comparisonScrollController.scrollingTextOffset,
          left: 5,
          child: SizedBox(
            height: 30,
            child: TextWidget(
              text: title,
              size: textSize,
              color: color,
              fontWeight: fontWeight,
            ),
          ),
        );
      },
    );
  }
}
