import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/bloc/interviewquestion/interview_question_bloc.dart';
import 'package:interviewquestion/bloc/interviewquestion/interview_question_state.dart';
import 'package:interviewquestion/model/interview_question_response.dart';
import 'package:interviewquestion/model/route/topic_route.dart';
import 'package:interviewquestion/util/vars.dart';
import 'package:line_icons/line_icons.dart';
import 'package:interviewquestion/util/extensions.dart';

class InterViewQuestionPage extends StatefulWidget {
  final TopicRoute topicRoute;

  const InterViewQuestionPage({Key key, this.topicRoute}) : super(key: key);

  @override
  createState() => _InterViewQuestionState();
}

class _InterViewQuestionState extends State<InterViewQuestionPage> {
  InterviewQuestionBloc interviewQuestionBloc;

  @override
  void initState() {
    super.initState();

    interviewQuestionBloc = BlocProvider.of<InterviewQuestionBloc>(context);
    interviewQuestionBloc
        .languageIdInput(widget.topicRoute.languageRoute.languageId);
    interviewQuestionBloc.topicIdInput(widget.topicRoute.topicId);
    interviewQuestionBloc.interviewQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: <
            Widget>[
      SliverAppBar(
          expandedHeight: 180.0,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: Icon(LineIcons.arrow_left, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          floating: true,
          pinned: true,
          flexibleSpace: Stack(children: <Widget>[
            ListView(children: <Widget>[
              SizedBox(height: 10.0),
              Text('',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
              SizedBox(height: 25.0),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: BlocBuilder(
                      bloc: interviewQuestionBloc,
                      builder: (BuildContext context,
                              InterviewQuestionState state) =>
                          TextField(
                              onChanged: interviewQuestionBloc.searchInput,
                              decoration: InputDecoration(
                                  hintText: 'Search question & answer',
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search))))))
            ])
          ])),
      SliverToBoxAdapter(child: SizedBox(height: 10.0)),
      BlocBuilder(
          bloc: interviewQuestionBloc,
          builder: (context, InterviewQuestionState state) {
            return state.loading
                ? SliverToBoxAdapter(
                    child: Container(
                        alignment: FractionalOffset.topCenter,
                        child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                colorProgressBar))))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                    return _topic(context, state.interviewQuestionList[index]);
                  }, childCount: state.interviewQuestionList.length));
          })
    ]));
  }

  _topic(BuildContext context,
      InterviewQuestionResponse interviewQuestionResponse) {
    return Container(
        margin: EdgeInsets.all(1.0),
        child: Card(
            elevation: 0.2,
            child: ExpansionTile(
                initiallyExpanded: false,
                title: Row(children: [
                  widget.expandStyle(
                      0,
                      Text(interviewQuestionResponse.id.toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: quickFont,
                              color: Color(0xFF757575)))),
                  widget.expandStyle(
                      1,
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(interviewQuestionResponse.question,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black))))
                ]),
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Text(interviewQuestionResponse.answer,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black)))
                ])));
  }
}
