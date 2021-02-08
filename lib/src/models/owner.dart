class Owner {  //Modelo para poder hacer parse a los servicios de github
  String login;
  int id;
  String node_id;
  String avatar_url;
  String url;
  String html_url;
  String type;

  Owner({this.login, this.id, this.node_id, this.avatar_url, this.url, this.html_url, this.type});

  factory Owner.fromJson(Map<String, dynamic> json){
    return Owner(
      login: json['login'],
      id: json['id'],
      node_id: json['node_id'],
      avatar_url: json['avatar_url'],
      html_url: json['html_url'],
      url: json['url'],
      type: json['type']
    );
  }
}