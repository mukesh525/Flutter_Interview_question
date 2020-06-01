import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/bloc/language/language_bloc.dart';
import 'package:interviewquestion/bloc/language/language_state.dart';
import 'package:interviewquestion/model/language_response.dart';
import 'package:interviewquestion/model/quiz_response.dart';
import 'package:interviewquestion/model/route/language_route.dart';
import 'package:interviewquestion/screen/widget/coordinator_layout.dart';
import 'package:interviewquestion/screen/widget/header.dart';
import 'package:interviewquestion/service/viewmodel/transaction.dart';
import 'package:interviewquestion/util/vars.dart';
import 'package:line_icons/line_icons.dart';

import 'summary_chart.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  LanguageBloc _languageBloc;
  int currentPageValue = 0;
  PageController controller;
  final ScrollController scrollController = ScrollController();

  List<Widget> onBoardingList = <Widget>[
    Center(child: Text('Best interview questions')),
    Center(child: Text('Best quiz questions')),
    Center(child: Text('Best new programming interview questions'))
  ];

  double minHeight;
  double maxHeight;
  int maxValue = 1000;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPageValue);

    _languageBloc = BlocProvider.of<LanguageBloc>(context);
    _languageBloc.language();
    _languageBloc.quiz();
  }

  void getChangePage(int page) {
    setState(() {
      currentPageValue = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    minHeight ??= MediaQuery.of(context).padding.top + kToolbarHeight;
    maxHeight ??= 360;

    return Scaffold(
        body: CoordinatorLayout(
      snap: true,
      scrollController: scrollController,
      header: buildCollapseHeader(context),
      body: buildMainContent(context),
    ));

    /*Scaffold(
        body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: <
            Widget>[
      SliverAppBar(
          expandedHeight: 180.0,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: Icon(LineIcons.navicon, color: Colors.white),
              onPressed: () {}),
          floating: true,
          pinned: true,
          flexibleSpace: Stack(children: <Widget>[
            ListView(children: <Widget>[
              SizedBox(height: 10.0),
              Text(appName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
              SizedBox(height: 25.0),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                              onPressed: () {}, icon: Icon(Icons.search)))))
            ])
          ])),
      SliverToBoxAdapter(
          child: Stack(children: <Widget>[
        Container(
            height: 90,
            child: PageView.builder(
                controller: controller,
                physics: ClampingScrollPhysics(),
                itemCount: onBoardingList.length,
                onPageChanged: (int i) {
                  getChangePage(i);
                },
                itemBuilder: (BuildContext context, int i) {
                  return onBoardingList[i];
                })),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < onBoardingList.length; i++)
                              if (i == currentPageValue) ...[
                                animatedDot(true)
                              ] else
                                animatedDot(false)
                          ]))
                ]))
      ])),
      SliverToBoxAdapter(child: SizedBox(height: 25.0)),
      SliverToBoxAdapter(
          child: Container(
              padding: EdgeInsets.all(5),
              child: Text('QUIZ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)))),
      SliverToBoxAdapter(
          child: Container(
              height: 100.0,
              child: BlocBuilder(
                  bloc: _languageBloc,
                  builder: (context, LanguageState state) => state.loading
                      ? Container(
                          alignment: FractionalOffset.topCenter,
                          child: CircularProgressIndicator(
                              strokeWidth: 1,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  colorProgressBar)),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.quizList.length,
                          itemBuilder: (context, index) {
                            return _newFeature(state.quizList[index]);
                          })))),
      SliverToBoxAdapter(child: SizedBox(height: 20.0)),
      SliverToBoxAdapter(
          child: Container(
              padding: EdgeInsets.all(5),
              child: Text('NEW LANGUAGE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)))),
      SliverToBoxAdapter(
          child: Container(
              height: 100.0,
              child: BlocBuilder(
                  bloc: _languageBloc,
                  builder: (context, LanguageState state) => state.loading
                      ? Container(
                          alignment: FractionalOffset.topCenter,
                          child: CircularProgressIndicator(
                              strokeWidth: 1,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  colorProgressBar)),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.languageList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                child: _newLanguage(state.languageList[index]),
                                onTap: () {
                                  Navigator.of(context).pushNamed(routeTopic,
                                      arguments: LanguageRoute(
                                          name: state.languageList[index].name,
                                          languageId:
                                              state.languageList[index].id));
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                });
                          })))),
      SliverToBoxAdapter(child: SizedBox(height: 25.0)),
      SliverToBoxAdapter(
          child: Container(
              padding: EdgeInsets.all(5),
              child: Text('ALL LANGUAGE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)))),
      BlocBuilder(
          bloc: _languageBloc,
          builder: (context, LanguageState state) {
            return state.loading
                ? SliverToBoxAdapter(
                    child: Container(
                    alignment: FractionalOffset.topCenter,
                    child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(colorProgressBar)),
                  ))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                    return GestureDetector(
                        child: _allLanguage(context, state.languageList[index]),
                        onTap: () {
                          Navigator.of(context).pushNamed(routeTopic,
                              arguments: LanguageRoute(
                                  name: state.languageList[index].name,
                                  languageId: state.languageList[index].id));
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                  }, childCount: state.languageList.length));
          })
    ]));*/
  }

  double offset = 0;
  SliverCollapseHeader buildCollapseHeader(BuildContext context) {
    return SliverCollapseHeader(
        minHeight: minHeight + 100,
        maxHeight: maxHeight,
        builder: (context, offset) {
          this.offset = offset;
          return Stack(children: <Widget>[
            Positioned.fill(bottom: 50, child: buildHeader(context, offset)),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Container(
                                  height: 100,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  child: Row(children: <Widget>[
                                    SizedBox(width: 8),
                                    Expanded(
                                        flex: 1,
                                        child: Stack(children: <Widget>[
                                          Container(
                                              height: 90,
                                              child: PageView.builder(
                                                  controller: controller,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  itemCount:
                                                      onBoardingList.length,
                                                  onPageChanged: (int i) {
                                                    getChangePage(i);
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return onBoardingList[i];
                                                  })),
                                          Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              for (int i = 0;
                                                                  i <
                                                                      onBoardingList
                                                                          .length;
                                                                  i++)
                                                                if (i ==
                                                                    currentPageValue) ...[
                                                                  animatedDot(
                                                                      true)
                                                                ] else
                                                                  animatedDot(
                                                                      false)
                                                            ]))
                                                  ]))
                                        ]))
                                  ]))))
                    ])))
          ]);
        });
  }

  SingleChildScrollView buildMainContent(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      SizedBox(height: 25.0),
      Container(
          padding: EdgeInsets.all(5),
          child: Text('QUIZ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))),
      Container(
          height: 100.0,
          child: BlocBuilder(
              bloc: _languageBloc,
              builder: (context, LanguageState state) => state.loading
                  ? Container(
                      alignment: FractionalOffset.topCenter,
                      child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(colorProgressBar)),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.quizList.length,
                      itemBuilder: (context, index) {
                        return _newFeature(state.quizList[index]);
                      }))),
      SizedBox(height: 25.0),
      Container(
          padding: EdgeInsets.all(5),
          child: Text('NEW LANGUAGE',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))),
      Container(
          height: 100.0,
          child: BlocBuilder(
              bloc: _languageBloc,
              builder: (context, LanguageState state) => state.loading
                  ? Container(
                      alignment: FractionalOffset.topCenter,
                      child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(colorProgressBar)),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.languageList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: _newLanguage(state.languageList[index]),
                            onTap: () {
                              Navigator.of(context).pushNamed(routeTopic,
                                  arguments: LanguageRoute(
                                      name: state.languageList[index].name,
                                      languageId:
                                          state.languageList[index].id));
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                      }))),
      SizedBox(height: 25.0),
      Container(
          padding: EdgeInsets.all(5),
          child: Text('ALL LANGUAGE',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))),
      Container(
          child: BlocBuilder(
              bloc: _languageBloc,
              builder: (context, LanguageState state) => state.loading
                  ? Container(
                      alignment: FractionalOffset.topCenter,
                      child: CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(colorProgressBar)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.languageList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: _allLanguage(
                                context, state.languageList[index]),
                            onTap: () {
                              Navigator.of(context).pushNamed(routeTopic,
                                  arguments: LanguageRoute(
                                      name: state.languageList[index].name,
                                      languageId:
                                          state.languageList[index].id));
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                      })))
    ]));
  }

  Widget buildHeader(BuildContext context, double offset) {
    return IgnorePointer(
        ignoring: false,
        child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue, Colors.blue]),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16 * (1 - offset)))),
            child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                    height: maxHeight - 50,
                    child: Stack(children: <Widget>[
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 24 * (1 - offset),
                          child: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              centerTitle: false,
                              title: Container(
                                  child: Text(
                                      offset == 1
                                          ? "Hi, fluttertutorial.in"
                                          : appName,
                                      style: TextStyle(
                                          fontSize: 18 + 16 * (1 - offset)))),
                              actions: <Widget>[])),
                      Positioned(
                          top: kToolbarHeight + 90,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                              child: Opacity(
                                  opacity: 1 - offset,
                                  child: SummaryChart(
                                      data1: totalReceived,
                                      data2: totalRedeem,
                                      maxValue: maxValue))))
                    ])))));
  }

  _newFeature(QuizResponse quizResponse) {
    return Card(
        elevation: 0.2,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: ExactAssetImage('assets/images/background.png'),
                    fit: BoxFit.values[3]),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            width: 100,
            height: 100,
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(quizResponse.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ])));
  }

  _newLanguage(LanguageResponse languageResponse) {
    final releaseDate = DateTime(languageResponse.releaseDate);
    final currentDate = DateTime(2020);
    final differenceCalculation =
        currentDate.difference(releaseDate).inDays / 365;

    return Offstage(
        offstage: differenceCalculation > 3 ? true : false,
        child: Card(
            elevation: 0.2,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/background.png'),
                        fit: BoxFit.values[3]),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                width: 100,
                height: 100,
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(languageResponse.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15))
                    ]))));
  }

  _allLanguage(BuildContext context, LanguageResponse languageResponse) {
    final releaseDate = DateTime(languageResponse.releaseDate);
    final currentDate = DateTime(2020);
    final differenceCalculation =
        currentDate.difference(releaseDate).inDays / 365;

    return Offstage(
        offstage: differenceCalculation > 3 ? false : true,
        child: Card(
            elevation: 0.2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: IntrinsicHeight(
                child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 65,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Icon(LineIcons.heart_o,
                                    color: Colors.white))
                          ]))),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  margin: EdgeInsets.only(right: 50),
                  padding: EdgeInsets.all(10),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Text(languageResponse.name,
                              style: TextStyle(color: Colors.black)),
                          Text(languageResponse.author,
                              style: TextStyle(color: Colors.black54)),
                          SizedBox(height: 10),
                          Text(languageResponse.releaseDate.toString(),
                              style: TextStyle(color: Colors.black45))
                        ])),
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(languageResponse.totalTopic,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)))
                  ]))
            ]))));
  }
}

animatedDot(bool active) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 100),
    curve: Curves.fastOutSlowIn,
    height: 2,
    width: 12,
    margin: EdgeInsets.only(
      left: 12,
    ),
    decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)),
  );
}
