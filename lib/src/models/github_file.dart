class GithubFile{  //Modelo para poder hacer parse a los servicios de github
  String sha;
  String filename;
  String status;
  int additions;
  int deletions;
  int changes;
  String contents_url;
  String blob_url;

  GithubFile({this.sha, this.filename, this.status, this.additions, this.deletions, this.changes, this.contents_url,this.blob_url});

  factory GithubFile.fromJson(Map<String, dynamic> json){
    return GithubFile(
      sha: json['sha'],
      filename: json['filename'],
      status: json['status'],
      additions: json['additions'],
      deletions: json['deletions'],
      changes: json['changes'],
      contents_url: json['contents_url'],
      blob_url: json['blob_url']
    );
  }
}