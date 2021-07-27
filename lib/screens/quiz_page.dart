import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_unescape/html_unescape.dart';

import '../models/category.dart';
import '../models/question.dart';
import 'quiz_finished.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;

  const QuizPage({Key? key, required this.questions, required this.category})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool goBack = false;
  final optionSelected = {};
  final TextStyle _questionStyle = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Question question = widget.questions[_currentIndex];
    final List options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text(
              widget.category.name,
              style: const TextStyle(color: Color(0xFF1E1B17)),
            ),
            centerTitle: true,
            toolbarHeight: 50,
            backgroundColor:const Color(0xFFFAD410),
            elevation: 0,
          ),
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(widget.category.imgUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
            )),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: widget.questions.length,
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: false,
                        height: size.height * 0.6,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        }),
                    itemBuilder: (context, index, index2) {
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white70,
                                    child: Text("${index + 1}"),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      HtmlUnescape().convert(
                                          widget.questions[index].question),
                                      softWrap: true,
                                      style: MediaQuery.of(context).size.width >
                                              800
                                          ? _questionStyle.copyWith(
                                              fontSize: 30.0)
                                          : _questionStyle,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ...options.map((option) =>
                                      RadioListTile<dynamic>(
                                        title: Text(
                                          HtmlUnescape().convert("$option"),
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  800
                                              ? const TextStyle(fontSize: 30.0)
                                              : null,
                                        ),
                                        groupValue: _answers[index],
                                        value: option,
                                        onChanged: (value) {
                                          debugPrint(value);
                                          setState(() {
                                              optionSelected.addAll({
                                                "$index": HtmlUnescape()
                                                    .convert("$option")
                                              });
                                            _answers[index] = option;
                                          });
                                        },
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          _currentIndex = _currentIndex - 1 < 0
                              ? _currentIndex
                              : _currentIndex - 1;
                          _controller.animateToPage(_currentIndex);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.angleLeft,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 10),
                    Text(
                      "${_currentIndex + 1} / ${widget.questions.length}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          _currentIndex =
                              _currentIndex > widget.questions.length - 1
                                  ? _currentIndex
                                  : _currentIndex + 1;
                          _controller.animateToPage(_currentIndex);
                        },
                        icon:const FaIcon(
                          FontAwesomeIcons.angleRight,
                          color: Colors.white,
                        )),
                  ],
                ),
                Offstage(
                  offstage: widget.questions.length - 1 != _currentIndex,
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: MediaQuery.of(context).size.width > 800
                            ? const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 64.0)
                            : null,
                      ),
                      child: Text(
                        "Submit",
                        style: MediaQuery.of(context).size.width > 800
                            ? const TextStyle(fontSize: 30.0)
                            : null,
                      ),
                      onPressed: _nextSubmit,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _nextSubmit() {
    optionSelected.forEach((key, value) {
      debugPrint("Key: " + key.toString() + " Value: " + value.toString());
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) =>
            QuizFinishedPage(questions: widget.questions, answers: _answers)));
  }

  Future<bool> _onWillPop() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Do you want to quit the quiz?"),
      action: SnackBarAction(
          label: "Yes",
          onPressed: () {
            setState(() {
              goBack = true;
            });
          }),
      duration: const Duration(seconds: 2),
    ));
    return goBack;
  }
}
