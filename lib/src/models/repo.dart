import 'owner.dart';

class Repo{  //Modelo para poder hacer parse a los servicios de github
    int id;
    String node_id;
    String name;
    String full_name;
    bool private;
    Owner owner;
    DateTime created_at;
    DateTime updated_at;
    DateTime pushed_at;
    String language;
    String license;
    String clone_url;
    String url;
    String html_url;

    Repo({this.id, this.node_id, this.name, this.full_name, this.private, this.owner, this.created_at, this.updated_at, this.pushed_at, this.language, this.license, this.clone_url, this.url, this.html_url});

    factory Repo.fromJson(Map<String, dynamic> json){
      return Repo(
        id: json['id'],
        node_id: json['node_id'],
        name: json['name'],
        full_name: json['full_name'],
        private: json['private'],
        owner: Owner.fromJson(json['owner']),
        created_at: DateTime.tryParse(json['created_at']),
        updated_at: DateTime.tryParse(json['updated_at']),
        pushed_at: DateTime.tryParse(json['pushed_at']),
        language: json['language'],
        license: json['license'],
        clone_url: json['clone_url'],
        url: json['url'],
        html_url: json['html_url']
      );
    }

}