class RankItem {
  String id;
  String questionUrl;
  String questionTitle;
  String hot;
  String rank;
  bool mark;

  RankItem(this.mark,
      {this.id, this.questionUrl, this.questionTitle, this.hot, this.rank});

  factory RankItem.fromJson(Map<String, dynamic> json) {
    return RankItem(false,
        id: json['id'],
        questionUrl: json['question_url'],
        questionTitle: json['question_title'],
        hot: json['hot'],
        rank: '10');
  }
}

class AnswerItem {
  int id;
  String authorName;
  String authorAvatarUrl;
  String authorHeadline;

  int createTime;
  int updatedTime;

  int voteUpCount;
  int commentCount;

  String contentDe;
  String content;

  AnswerItem(
      {this.id,
      this.authorName,
      this.authorAvatarUrl,
      this.authorHeadline,
      this.createTime,
      this.updatedTime,
      this.voteUpCount,
      this.commentCount,
      this.contentDe,
      this.content});

  factory AnswerItem.fromJson(Map<String, dynamic> json) {
    return AnswerItem(
        id: json['id'],
        authorName: json['author']['name'],
        authorAvatarUrl: json['author']['avatar_url'],
        authorHeadline: json['author']['headline'],
        createTime: json['created_time'],
        updatedTime: json['updated_time'],
        voteUpCount: json['voteup_count'],
        commentCount: json['comment_count'],
        contentDe: json['content_de'],
        content: json['content']);
  }

  factory AnswerItem.fromJsonV1(Map<String, dynamic> json) {
    print(json);
    return AnswerItem(
        id: json['id'],
        authorName: json['author']['name'],
        authorAvatarUrl: json['author']['avatar_url'],
        authorHeadline: json['author']['headline'],
        createTime: json['created_time'],
        updatedTime: json['updated_time'],
        voteUpCount: json['voteup_count'],
        commentCount: json['comment_count'],
        contentDe: '',
        content: json['content']);
  }
}

class QuestionItem {
  String id;
  String questionUrl;
  String questionTitle;

  List<AnswerItem> answers;

  QuestionItem({this.id, this.questionTitle, this.questionUrl, this.answers});

  factory QuestionItem.fromJson(Map<String, dynamic> json) {
    List<AnswerItem> answers = [];
    dynamic jsonAnswers = json['answers'];

    for (var i = 0; i < jsonAnswers.length; i++) {
      answers.add(AnswerItem.fromJson(jsonAnswers[i]));
    }

    return QuestionItem(
        id: json['_id'],
        questionTitle: json['question_title'],
        questionUrl: json['question_url'],
        answers: answers);
  }
}
