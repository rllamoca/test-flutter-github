import 'dart:async';

import 'package:meta/meta.dart';
import 'package:testgithub/src/models/detail_commit.dart';
import 'package:testgithub/src/models/repo.dart';

import './rest_service_client.dart';

/* Esta clase actua como intermediaria a Rest Service Client 
aqui no se hace logica alguna 
*/
class RestServiceRepository {
  final RestServiceClient restServiceClient;

  RestServiceRepository({@required this.restServiceClient})
      : assert(restServiceClient != null);

  Future<Repo> getRepoInfo() async {
    return await restServiceClient.getRepoInfo();
  }

  Future<List<DetailCommit>> getCommits() async {
    return await restServiceClient.getCommits();
  }

  Future<DetailCommit> getCommitDetail(String sha) async {
    return await restServiceClient.getCommitDetail(sha);
  }

}
