import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themeColors.dart';
import '../../home/model/article.dart';
import '../../bloc/detail_page_bloc.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  DetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPageBloc(article.comments),
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(article.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.fullText,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Author: ${article.author}',
                          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Date: ${article.date}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Comments:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                SizedBox(height: 8),
                BlocBuilder<DetailPageBloc, DetailPageState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(state.comments[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
                CommentInputField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CommentInputField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                context.read<DetailPageBloc>().add(AddCommentEvent(comment: _controller.text));
                _controller.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: CircleBorder(),
              padding: EdgeInsets.all(16),
            ),
            child: Icon(Icons.send, color: cardColor,),
          ),
        ],
      ),
    );
  }
}