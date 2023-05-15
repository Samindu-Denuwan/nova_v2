import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';

class MessageState{

RxList<QueryDocumentSnapshot<Msg>>msgList = <QueryDocumentSnapshot<Msg>>[].obs;
}