class ThirdNode {
  String type;
  String fourth;
  ThirdNode({this.type, this.fourth});

  ThirdNode.fromMap(Map<String, dynamic> map) {
    type = map['type'] as String;
    fourth = map['fourth'] as String;
  }
}

class SecondNode {
  String type;
  List<dynamic> third;
  SecondNode({this.type, this.third});

  SecondNode.fromMap(Map<String, dynamic> map) {
    type = map['type'] as String;
    third = map['third'].map((fourth) => ThirdNode.fromMap(fourth)).toList();
  }
}

class FirstNode {
  String title;
  List<dynamic> second;
  FirstNode({this.title, this.second});

  FirstNode.fromMap(Map<String, dynamic> map) {
    title = map['title'] as String;
    second = map['second'].map((third) => SecondNode.fromMap(third)).toList();
  }
}

class Project {
  String id;
  String author;
  String authorImage;
  String title;
  String subtitle;
  String image;
  String gitHubUser;
  String gitHubSource;
  List<dynamic> first;
  Project({
    this.id,
    this.author,
    this.authorImage,
    this.title,
    this.subtitle,
    this.image,
    this.gitHubUser,
    this.gitHubSource,
    this.first,
  });

  Project.fromMap(Map<String, dynamic> map) {
    id = map['id'] as String;
    author = map['author'] as String;
    authorImage = map['authorImage'] as String;
    title = map['title'] as String;
    subtitle = map['subtitle'] as String;
    image = map['image'] as String;
    gitHubUser = map['gitHubUser'] as String;
    gitHubSource = map['gitHubSource'] as String;
    first = map['first'].map((second) => FirstNode.fromMap(second)).toList();
  }
}
