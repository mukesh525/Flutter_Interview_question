import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/bloc/topic/topic_bloc.dart';
import 'package:interviewquestion/bloc/topic/topic_state.dart';
import 'package:interviewquestion/model/route/language_route.dart';
import 'package:interviewquestion/model/route/topic_route.dart';
import 'package:interviewquestion/model/topic_response.dart';
import 'package:interviewquestion/util/vars.dart';
import 'package:line_icons/line_icons.dart';

class TopicPage extends StatefulWidget {
  final LanguageRoute languageRoute;

  const TopicPage({Key key, this.languageRoute}) : super(key: key);

  @override
  createState() => _TopicState();
}

class _TopicState extends State<TopicPage> {
  TopicBloc _topicBloc;

  @override
  void initState() {
    super.initState();

    _topicBloc = BlocProvider.of<TopicBloc>(context);
    _topicBloc.languageIdInput(widget.languageRoute.languageId);
    _topicBloc.topic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0)),
                      child: BlocBuilder(
                          bloc: _topicBloc,
                          builder: (BuildContext context, TopicState state) =>
                              TextField(
                                  onChanged: _topicBloc.searchInput,
                                  decoration: InputDecoration(
                                      hintText: 'Search topic ' +
                                          widget.languageRoute.name
                                              .toLowerCase(),
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.search))))))
                ])
              ])),
          SliverToBoxAdapter(child: SizedBox(height: 10.0)),
          BlocBuilder(
              bloc: _topicBloc,
              builder: (context, TopicState state) {
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
                        return GestureDetector(
                            child: _topic(context, state.topicList[index]),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  routeInterViewQuestion,
                                  arguments: TopicRoute(
                                      topicId: state.topicList[index].id,
                                      name: state.topicList[index].topic,
                                      languageRoute: widget.languageRoute));
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                      }, childCount: state.topicList.length));
              })
        ]));
  }

  _topic(BuildContext context, TopicResponse topicResponse) {
    return Card(
        elevation: 0.1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            child: Text(topicResponse.topic,
                style: TextStyle(color: Colors.black))));
  }
}
