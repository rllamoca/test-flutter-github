import 'commit.dart';
import 'github_file.dart';
import 'owner.dart';
import 'stat.dart';

class DetailCommit{  //Modelo para poder hacer parse a los servicios de github
  String sha;
  String node_id;
  Commit commit;
  Owner author;
  Stat stats;
  List<GithubFile> files;

  DetailCommit({this.sha, this.node_id, this.commit, this.author,this.stats,this.files});

  factory DetailCommit.fromJson(Map<String, dynamic> jsons){
    List<GithubFile> fils = [];
    if(jsons['files'] != null){
      Iterable list = jsons['files'];
      fils = list.map((model) => GithubFile.fromJson(model)).toList();
    }
    return DetailCommit(
      sha: jsons['sha'],
      node_id: jsons['node_id'],
      commit: Commit.fromJson(jsons['commit']),
      author: Owner.fromJson(jsons['author']),
      stats: jsons['stats'] != null ? Stat.fromJson(jsons['stats']) : null,
      files: fils
    );
  }
}